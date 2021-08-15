import Foundation

class DefaultTags {
  var tags = [
    Tag(name: "безделье", id: "1"),
    Tag(name: "кино", id: "2"),
    Tag(name: "прогулка", id: "3"),
    Tag(name: "спорт", id: "4"),
    Tag(name: "чтение", id: "5"),
    Tag(name: "игра", id: "6"),
    Tag(name: "музыка", id: "7"),
    Tag(name: "уборка", id: "8"),
    Tag(name: "готовка", id: "9"),

    Tag(name: "волнение", id: "10"),
    Tag(name: "апатия", id: "11"),
    Tag(name: "вдохновение", id: "12"),
    Tag(name: "грусть", id: "13"),
    Tag(name: "тревога", id: "14"),
    Tag(name: "стресс", id: "15"),
    Tag(name: "одиночество", id: "16"),
    Tag(name: "раздражение", id: "17"),

    Tag(name: "поздний подъём", id: "18"),
    Tag(name: "ранний подъём", id: "19"),
    Tag(name: "не выспался", id: "20"),
    Tag(name: "выспался", id: "21"),

    Tag(name: "кофе", id: "22"),
    Tag(name: "чай", id: "23"),
    Tag(name: "вкусная еда", id: "24"),
    Tag(name: "невкусная еда", id: "25"),
    Tag(name: "чувство голода", id: "26"),

    Tag(name: "болезнь", id: "27"),
    Tag(name: "усталость", id: "28")
  ]

  var groups = [
    TagGroup(title: "Досуг", tagIds: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]),
    TagGroup(title: "Эмоции", tagIds: ["10", "11", "12", "13", "14", "15", "16", "17"]),
    TagGroup(title: "Сон", tagIds: ["18", "19", "20", "21"]),
    TagGroup(title: "Еда", tagIds: ["22", "23", "24", "25", "26"]),
    TagGroup(title: "Самочувствие", tagIds: ["27", "28"])
  ]
}

