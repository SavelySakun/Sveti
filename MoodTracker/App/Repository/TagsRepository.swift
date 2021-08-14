import Foundation

class TagsRepository {

  var tags = [
    Tag(name: "отдых", id: "1"),
    Tag(name: "безделье", id: "2"),
    Tag(name: "кулинария", id: "3"),
    Tag(name: "уборка", id: "4"),
    Tag(name: "чтение", id: "5"),
    Tag(name: "игра", id: "6"),
    Tag(name: "кино", id: "7"),
    Tag(name: "стресс", id: "8"),
    Tag(name: "кодинг", id: "9"),
    Tag(name: "созвон", id: "10"),
    Tag(name: "сон", id: "11"),
    Tag(name: "спорт", id: "12"),
    Tag(name: "медитация", id: "13"),
    Tag(name: "прогулка", id: "14"),
    Tag(name: "рисование", id: "15"),
    Tag(name: "пробежка", id: "16"),
    Tag(name: "кризис", id: "17"),
    Tag(name: "счастье", id: "18"),
    Tag(name: "пупырка", id: "19"),
    Tag(name: "пам пам", id: "20"),
  ]

  var tagGroups = [
    ExpandableTagGroup(title: "Дом", tagIds: ["1", "2", "3", "4", "5"]),
    ExpandableTagGroup(title: "Прочее", tagIds: ["6", "7", "8", "9", "10", "11", "12", "13", "14"]),
    ExpandableTagGroup(title: "Прочее", tagIds: ["15", "16", "17", "18", "19", "20"])
  ]

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
}
