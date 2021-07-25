import UIKit
import RealmSwift

struct DiarySection {
  var date = Date()
  var notes = [Note]()
}

class DiaryVM {

  var notes = [Note]()
  var notesGroupedByDay = [DiarySection]()

  init() {
    loadNotes()
  }

  func loadNotes() {
    notes = NotesRepository().getNotes()
    configureSections(from: notes)
  }

  func configureSections(from notes: [Note]) {

    let dict = Dictionary(grouping: notes) { $0.splitDate?.ddMMyyyy }
    print(dict)

  }



}
