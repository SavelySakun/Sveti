import Foundation

class DefaultTags {
  let groups = [
    TagGroup(title: "Leisure".localized, tags: [
      Tag(name: "idleness".localized, id: "1"),
      Tag(name: "movie".localized, id: "2"),
      Tag(name: "walk".localized, id: "4"),
      Tag(name: "reading".localized, id: "5"),
      Tag(name: "game".localized, id: "6"),
      Tag(name: "music".localized, id: "7"),
      Tag(name: "cleaning".localized, id: "8"),
      Tag(name: "cooking".localized, id: "9")
    ]),

    TagGroup(title: "Emotions".localized, tags: [
      Tag(name: "excitement".localized, id: "10"),
      Tag(name: "apathy".localized, id: "11"),
      Tag(name: "inspiration".localized, id: "12"),
      Tag(name: "sadness".localized, id: "13"),
      Tag(name: "anxiety".localized, id: "14"),
      Tag(name: "stress".localized, id: "15"),
      Tag(name: "loneliness".localized, id: "16"),
      Tag(name: "irritation".localized, id: "17")
    ]),

    TagGroup(title: "Sleep".localized, tags: [
      Tag(name: "late rise".localized, id: "18"),
      Tag(name: "early rise".localized, id: "19"),
      Tag(name: "not enough sleep".localized, id: "20"),
      Tag(name: "slept well".localized, id: "21")
    ]),

    TagGroup(title: "Food".localized, tags: [
      Tag(name: "coffee".localized, id: "22"),
      Tag(name: "tea".localized, id: "23"),
      Tag(name: "tasty food".localized, id: "24"),
      Tag(name: "tasteless food".localized, id: "25"),
      Tag(name: "hunger".localized, id: "26")
    ]),

    TagGroup(title: "Health".localized, tags: [
      Tag(name: "disease".localized, id: "27"),
      Tag(name: "fatigue".localized, id: "28")
    ])
  ]

  let testGroups = [
    TagGroup(title: "Health", tags: [
      Tag(name: "good", id: "1"),
      Tag(name: "bad", id: "2")
    ], id: "health"),

    TagGroup(title: "Activity", tags: [
      Tag(name: "read", id: "3")
    ], id: "activity")
  ]
}
