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

  func deleteNote(noteId: Int) {
    NotesRepository().deleteNote(noteId: noteId)
  }

  func configureSections(from notes: [Note]) {
    let groupedByDate = Dictionary(grouping: notes) { $0.splitDate?.dMMMMyyyy }

    var dateForSection = notes.first?.splitDate?.dMMMMyyyy
    var notesForSection = groupedByDate[dateForSection]
    var newSection = DiarySection(date: dateForSection ?? "", notes: notesForSection ?? [])

    for note in notes {
      let noteDate = note.splitDate?.dMMMMyyyy
      guard sections.last?.date != noteDate else { continue }

      if noteDate == dateForSection {
        sections.append(newSection)
      } else {
        dateForSection = noteDate
        notesForSection = groupedByDate[dateForSection]
        newSection = DiarySection(date: dateForSection ?? "", notes: notesForSection ?? [])
        sections.append(newSection)
      }
    }

  }


}
