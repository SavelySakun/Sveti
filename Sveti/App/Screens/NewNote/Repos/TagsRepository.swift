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
    let groups = DefaultTags().groups
    let tagGroupList = TagGroupList()

    groups.forEach { group in
      tagGroupList.groupList.append(group)
    }

    try! realm.write {
      realm.add(tagGroupList)
    }

    userDefaults.set(true, forKey: UDKeys.isDefaultTagsSaved)
  }

  func findTag(with id: String) -> Tag? {
    var tag: Tag?
    groups.forEach { group in
      guard tag == nil else { return }
      tag = group.tags.first { $0.id == id }
    }
    return tag
  }

  func getTags(with name: String) -> [Tag] {
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

  func findGroupId(with number: Int) -> String {
    groups[number].id
  }

  func getGroup(with id: String) -> TagGroup? {
    return groups.first { $0.id == id }
  }

  func updateTagHiddenStatus(with id: String) {
    guard let tag = findTag(with: id) else { return }
    try! realm.write {
      tag.isHidden = !tag.isHidden
    }
  }

  func getActiveTagsCount(in section: Int) -> Int {
    let activeTags = getActiveTags(in: section)
    return activeTags.count
  }

  func getActiveTags(in section: Int) -> [Tag]{
    groups[section].tags.filter { $0.isHidden == false }
  }

  func renameTag(withId id: String, and newName: String) {
    guard let tag = findTag(with: id) else { return }
    try! realm.write {
      tag.name = newName
    }
  }

  func removeTag(with id: String) {
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
          let tagToMove = findTag(with: tagId) else { return }
    removeTag(with: tagId)
    try! realm.write {
      groups[indexOfNewGroup].tags.append(tagToMove)
    }
  }

  func addNewTag(name: String, groupId: String) {
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

  func reorder(moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, and groupId: String) {
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

  func addNewGroup(with name: String, id: String) {
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
}
