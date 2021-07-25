import Foundation
import RealmSwift

enum TimeRange {
  case all
  case today
  case thisWeek
  case thisMonth
  case thisYear
}

class NotesRepository {

  let realm = try! Realm()

  func save(_ note: Note) {

//    try! realm.write {
//      realm.deleteAll()
//    }
//    return


    let noteToSave = getPreparedToSave(note)
    try! realm.write {
      realm.add(noteToSave)
    }
  }

  func getNotes(range: TimeRange = .all) -> [Note] {
    let notes = realm.objects(Note.self).sorted(byKeyPath: "id", ascending: false).toArray()
    return notes
  }

  private func getPreparedToSave(_ note: Note) -> Note {
    let note = note
    let currentDate = Date()
    let splitDate = SplitDate(rawDate: currentDate)
    note.splitDate = splitDate
    note.id = Int(currentDate.timeIntervalSince1970)
    return note
  }
  
}





