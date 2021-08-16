import Foundation
import RealmSwift

class TagsRepository {

  private let realm = try! Realm()
  private let userDefaults = UserDefaults()

  private var tags: [Tag]
  var groups: [TagGroup]

  init() {
    tags = realm.objects(Tag.self).toArray()
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

    let defaultTags = DefaultTags()
    let tags = defaultTags.tags
    let groups = defaultTags.groups

    try! realm.write {
      realm.add(tags)
      realm.add(groups)
    }

    userDefaults.set(true, forKey: UDKeys.isDefaultTagsSaved)
  }

  func getTag(with id: String) -> Tag? {
    return tags.first { $0.id == id }
  }

  func getTagIds(with name: String) -> [String] {
    var tagIds = [String]()
    let filteredTags = tags.filter { tag in
      return tag.name.lowercased().contains(name.lowercased())
    }

    filteredTags.forEach { tag in
      tagIds.append(tag.id)
    }

    return tagIds
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
}
