import Foundation
import RealmSwift

class NotesRepository {

  private var realm: Realm {
    try! Realm()
  }

  func save(_ note: Note) {
    try! realm.write {
      realm.add(note, update: .all)
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

  func removeTagFromNotes(tagId: String) {
    let notes = realm.objects(Note.self).toArray()
    DispatchQueue.main.async {
      let notesWithTag = notes.filter { $0.tags.contains { $0.id == tagId } }
      notesWithTag.forEach { note in
        let tagsArray = note.tags.toArray()
        let filteredTags = tagsArray.filter { $0.id != tagId }
        try! self.realm.write {
          note.tags.removeAll()
          note.tags.append(objectsIn: filteredTags)
        }
      }
    }
  }

  func removeAll() {
    let object = realm.objects(Note.self)
    try! realm.write {
      realm.delete(object)
    }
  }
}
