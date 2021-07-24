import UIKit
import RealmSwift

class DiaryVM {

  var notes = [Note]()

  init() {
    loadNotes()
  }

  func loadNotes() {
    notes = NotesRepository().getNotes()
  }

}
