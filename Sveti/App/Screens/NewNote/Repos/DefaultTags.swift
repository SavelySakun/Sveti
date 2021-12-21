import Foundation

class DefaultTags {
  let groups = [
    TagGroup(title: "Leisure", tags: [
      Tag(name: "idleness", id: "1"),
      Tag(name: "movie", id: "2"),
      Tag(name: "walk", id: "4"),
      Tag(name: "reading", id: "5"),
      Tag(name: "game", id: "6"),
      Tag(name: "music", id: "7"),
      Tag(name: "cleaning", id: "8"),
      Tag(name: "cooking", id: "9"),
    ]),

    TagGroup(title: "Emotions", tags: [
      Tag(name: "excitement", id: "10"),
      Tag(name: "apathy", id: "11"),
      Tag(name: "inspiration", id: "12"),
      Tag(name: "sadness", id: "13"),
      Tag(name: "anxiety", id: "14"),
      Tag(name: "stress", id: "15"),
      Tag(name: "loneliness", id: "16"),
      Tag(name: "irritation", id: "17"),
    ]),

    TagGroup(title: "Sleep", tags: [
      Tag(name: "late rise", id: "18"),
      Tag(name: "early rise", id: "19"),
      Tag(name: "not enough sleep", id: "20"),
      Tag(name: "slept well", id: "21"),
    ]),

    TagGroup(title: "Food", tags: [
      Tag(name: "coffee", id: "22"),
      Tag(name: "tea", id: "23"),
      Tag(name: "tasty food", id: "24"),
      Tag(name: "tasteless food", id: "25"),
      Tag(name: "hunger", id: "26"),
    ]),

    TagGroup(title: "Health", tags: [
      Tag(name: "disease", id: "27"),
      Tag(name: "fatigue", id: "28")
    ])
  ]

  let testGroups = [
    TagGroup(title: "Health", tags: [
      Tag(name: "good", id: "1"),
      Tag(name: "bad", id: "2"),
    ], id: "health"),

    TagGroup(title: "Activity", tags: [
      Tag(name: "read", id: "3")
    ], id: "activity")
  ]
}

