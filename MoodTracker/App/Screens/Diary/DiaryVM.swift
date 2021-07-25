import UIKit
import RealmSwift

struct DiarySection {
  var date = String()
  var notes = [Note]()
}

class DiaryVM {

  var sections = [DiarySection]()

  init() {
    loadNotes()
  }

  func loadNotes() {
    sections.removeAll()
    let notes = NotesRepository().getNotes()
    configureSections(from: notes)
  }

  func configureSections(from notes: [Note]) {
    let groupedByDate = Dictionary(grouping: notes) { $0.splitDate?.ddMMyyyy }

    var dateForSection = notes.first?.splitDate?.ddMMyyyy
    let notesForSection = groupedByDate[dateForSection]


    let newSection = DiarySection(date: dateForSection ?? "", notes: notesForSection ?? [])

    notes.forEach { note in
      let noteDate = note.splitDate?.ddMMyyyy

      if noteDate == dateForSection {
        guard sections.last?.date != dateForSection else { return }
        sections.append(newSection)
      } else {
        dateForSection = noteDate
      }

    }
  }



}
