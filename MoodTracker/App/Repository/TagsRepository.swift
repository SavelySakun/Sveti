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
  ]

  var tagGroups = [
    TagGroup(title: "Дом", tagIds: ["1", "2", "3", "4", "5"]),
    TagGroup(title: "Работа", tagIds: ["6", "7", "8"]),
    TagGroup(title: "Прочее", tagIds: ["9", "10", "11", "12", "13", "14"])
  ]

  func getTag(with id: String) -> Tag? {
    return tags.first { $0.id == id }
  }
}