import Foundation
import RealmSwift

class TagsRepository {

  private let realm = try! Realm()
  private let userDefaults = UserDefaults()

  var groups: [TagGroup]

  init() {
    groups = realm.objects(TagGroup.self).toArray()
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

    try! realm.write {
      realm.add(groups)
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

  func updateHidden(with id: String) {
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
}
