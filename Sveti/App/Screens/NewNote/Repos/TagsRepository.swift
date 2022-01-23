import Foundation
import RealmSwift

class TagsRepository {

  private let realm = try! Realm()
  private let userDefaults = UserDefaults()

  var groups: [TagGroup] {
    let tagGroupList = realm.objects(TagGroupList.self).last
    let groupList = tagGroupList?.groupList.toArray() ?? [TagGroup]()
    return groupList
  }

  init() {
    setupDefaults()
  }

  func setupDefaults() {
    userDefaults.register(
      defaults: [UDKeys.isDefaultTagsSaved: false]
    )
  }

  func saveDefaultTags() {
    let isSaved = userDefaults.bool(forKey: UDKeys.isDefaultTagsSaved)

    guard !isSaved else { return }
    let defaultDags = DefaultTags()
    let groups: [TagGroup] = TestHelper.isTestMode ? defaultDags.testGroups : defaultDags.groups
    let tagGroupList = TagGroupList()

    groups.forEach { group in
      tagGroupList.groupList.append(group)
    }

    try! realm.write {
      realm.add(tagGroupList)
    }

    userDefaults.set(true, forKey: UDKeys.isDefaultTagsSaved)
  }

  func findTag(withId id: String) -> Tag? {
    var tag: Tag?
    groups.forEach { group in
      guard tag == nil else { return }
      tag = group.tags.first { $0.id == id }
    }
    return tag
  }

  func getTags(withName name: String) -> [Tag] {
    var tags = [Tag]()
    let searchedGroups = groups

    searchedGroups.forEach { group in
      let filteredTags = group.tags.filter { tag in
        return tag.name.lowercased().contains(name.lowercased())
      }
      tags += Array(filteredTags)
    }

    return tags
  }

  func updateExpandStatus(groupIndex: Int) {
    let isExpanded = groups[groupIndex].isExpanded
    try! realm.write {
      groups[groupIndex].isExpanded = !isExpanded
    }
  }

  func findGroupId(withIndex number: Int) -> String {
    groups[number].id
  }

  func getGroup(withId id: String) -> TagGroup? {
    return groups.first { $0.id == id }
  }

  func updateTagHiddenStatus(withId id: String) {
    guard let tag = findTag(withId: id) else { return }
    try! realm.write {
      tag.isHidden = !tag.isHidden
    }
  }

  func getActiveTagsCount(in section: Int) -> Int {
    let activeTags = getActiveTags(in: section)
    return activeTags.count
  }

  func getActiveTags(in section: Int) -> [Tag] {
    guard !groups.isEmpty else { return [Tag]() }
    return groups[section].tags.filter { $0.isHidden == false }
  }

  func renameTag(withId id: String, newName: String) {
    guard let tag = findTag(withId: id) else { return }
    try! realm.write {
      tag.name = newName
    }
  }

  func removeTag(withId id: String) {
    var indexOfDeletingTag: Int?
    var indexOfGroup = 0

    for (index, group) in groups.enumerated() {
      guard indexOfDeletingTag == nil else { break }
      indexOfDeletingTag = group.tags.firstIndex { $0.id == id }
      indexOfGroup = index
    }

    guard let existTagIndex = indexOfDeletingTag else { return }
    try! realm.write {
      groups[indexOfGroup].tags.remove(at: existTagIndex)
    }
  }

  func moveTagTo(newGroupId: String, tagId: String) {
    guard let indexOfNewGroup = groups.firstIndex(where: { $0.id == newGroupId }),
          let tagToMove = findTag(withId: tagId) else { return }
    removeTag(withId: tagId)
    try! realm.write {
      groups[indexOfNewGroup].tags.append(tagToMove)
    }
  }

  func addNewTag(withName name: String, groupId: String) {
    try! realm.write {
      let newTag = Tag(name: name)
      guard let index = groups.firstIndex(where: { $0.id == groupId }) else { return }
      groups[index].tags.append(newTag)
    }
  }

  func deleteGroup(with id: String) {
    let tagGroupList = realm.objects(TagGroupList.self).last?.groupList
    guard let indexOfGroupToDelete = tagGroupList?.firstIndex(where: { $0.id == id }) else { return }
    try! realm.write {
      tagGroupList?.remove(at: indexOfGroupToDelete)
    }
  }

  func reorder(moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, groupId: String) {
    let editingGroup = groups.first(where: { $0.id == groupId })
    try! realm.write {
      editingGroup?.tags.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
  }

  func renameGroup(with id: String, newName: String) {
    guard let groupToRename = groups.first(where: { $0.id == id }) else { return }
    try! realm.write {
      groupToRename.title = newName
    }
  }

  func addNewGroup(withName name: String, id: String) {
    let tagGroup = TagGroup(title: name, tags: [Tag](), id: id)
    guard let tagGroupList = realm.objects(TagGroupList.self).last else { return }
    try! realm.write {
      tagGroupList.groupList.append(tagGroup)
    }
  }

  func reorderGroup(moveGroupAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let tagGroupList = realm.objects(TagGroupList.self).last
    try! realm.write {
      tagGroupList?.groupList.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
  }

  func removeAll() {
    let object = realm.objects(TagGroupList.self)
    try! realm.write {
      realm.delete(object)
    }
  }
}
