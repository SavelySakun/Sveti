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

    let noteToSave = getPreparedToSave(note)
    try! realm.write {
      realm.add(noteToSave)
    }
  }

  func getNotes(range: TimeRange = .all) -> [Note] {
    var notes = realm.objects(Note.self).toArray()
    notes.sort(by: >)
    return notes
  }

  func deleteNote(noteId: Int) {
    let object = realm.objects(Note.self).filter("id = %@", noteId)
    try! realm.write {
      realm.delete(object)
    }
  }

  func getNote(with id: Int) -> Note? {
    return realm.objects(Note.self).filter("id = %@", id).first
  }

  private func getPreparedToSave(_ note: Note) -> Note {
    let note = note
    let date = Date()
    note.id = Int(date.timeIntervalSince1970)
    return note
  }
}
