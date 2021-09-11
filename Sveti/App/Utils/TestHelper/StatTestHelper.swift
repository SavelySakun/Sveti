import Foundation

class StatTestHelper {

  let defaultDate = "01.01.2021"
  let testDate = "10.02.2021"
  lazy var defaultStatDay: StatDay = {
    let statDay = StatDay()
    statDay.date = defaultDate
    statDay.phyzicalStates.append(objectsIn: [1.0, 2.0])
    statDay.emotionalStates.append(objectsIn: [1.0, 2.0])
    statDay.totalNotes = 2.0
    return statDay
  }()

  let defaultNote: Note = {
    let note = Note()
    let date = Date(timeIntervalSince1970: 1609459200) // return "01.01.2021"
    note.id = 1 // default test value
    note.splitDate = SplitDate(rawDate: date)
    note.mood?.physicalState = 2.0
    note.mood?.emotionalState = 2.0
    return note
  }()
  
}
