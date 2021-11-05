import UIKit
import RealmSwift

struct DiarySection {
  var date = String()
  var average: String?
  var notes = [Note]()
}

class DiaryVM {

  var sections = [DiarySection]()
  private let noteRepository = NotesRepository()

  init() {
    loadNotes()
  }

  func loadNotes() {
    sections.removeAll()
    let notes = noteRepository.getNotes()
    configureSections(from: notes)
  }

  func deleteNote(noteId: Int) {
    guard let note = noteRepository.getNote(with: noteId) else { return }
    StatDaysManager().removeStat(with: note)
    noteRepository.deleteNote(noteId: noteId)
  }

  func configureSections(from notes: [Note]) {
    let groupedByDate = Dictionary(grouping: notes) { $0.splitDate?.dMMMMyyyy }

    var dateForSection = notes.first?.splitDate?.dMMMMyyyy
    var notesForSection = groupedByDate[dateForSection]
    var newSection = DiarySection(date: dateForSection ?? "", average: getAverageForSection(with: notesForSection), notes: notesForSection ?? [])

    for note in notes {
      let noteDate = note.splitDate?.dMMMMyyyy
      guard sections.last?.date != noteDate else { continue }

      if noteDate == dateForSection {
        sections.append(newSection)
      } else {
        dateForSection = noteDate
        notesForSection = groupedByDate[dateForSection]
        newSection = DiarySection(date: dateForSection ?? "", notes: notesForSection ?? [])
        newSection.average = getAverageForSection(with: notesForSection)
        sections.append(newSection)
      }
    }
  }

  private func getAverageForSection(with notes: [Note]?) -> String? {
    guard let notes = notes else { return nil }
    guard notes.count > 1 else { return nil }
    let mathHelper = MathHelper()
    var totalScore: Float = 0
    var totalNotes: Float = 0

    for note in notes {
      guard let average = note.mood?.average else { continue }
      totalScore += average
      totalNotes += 1.0
    }

    let averageScore = totalScore / totalNotes
    return mathHelper.getMoodScore(from: averageScore, digits: 1)
  }

}
