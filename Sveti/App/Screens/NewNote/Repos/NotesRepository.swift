import Foundation
import RealmSwift

class NotesRepository {

  private var realm: Realm {
    try! Realm()
  }

  func save(_ note: Note) {
    try! realm.write {
      realm.add(note)
    }
  }

  func getNotes() -> [Note] {
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

  func removeAll() {
    let object = realm.objects(Note.self)
    try! realm.write {
      realm.delete(object)
    }
  }
}
