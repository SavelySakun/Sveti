import UIKit
import RealmSwift

struct DiarySection {
  var date = SplitDate()
  var average: String?
  var notes = [Note]()
}

class DiaryVM {

  var sectionsWithNotes = [DiarySection]()
  private let noteRepository = NotesRepository()

  init() {
    loadNotes()
  }

  func loadNotes() {
    sectionsWithNotes.removeAll()
    let notes = noteRepository.getNotes()
    configureSections(from: notes)
  }

  func deleteNote(noteId: Int) {
    guard let note = noteRepository.getNote(with: noteId) else { return }
    StatDaysDataManager().removeStat(with: note)
    noteRepository.deleteNote(noteId: noteId)
  }

  func configureSections(from notes: [Note]) {
    let notesGroupedByDate = Dictionary(grouping: notes) { $0.splitDate?.ddMMyy }
    guard let firstNoteSplitDate = notes.first?.splitDate else { return }

    var dateForSection = firstNoteSplitDate.ddMMyy
    var notesForSection = notesGroupedByDate[dateForSection]
    var currentlyEditingSection = DiarySection(date: firstNoteSplitDate, average: getAverageForSection(with: notesForSection), notes: notesForSection ?? [])

    for note in notes {
      guard let noteDate = note.splitDate,
            // Check is section with this note date already exist. If exist -> check next note.
            sectionsWithNotes.last?.date.ddMMyy != noteDate.ddMMyy else { continue }

      // If note date equal to the date of current editing section -> section is already configured, put it in the sections array.
      if noteDate.ddMMyy == dateForSection {
        sectionsWithNotes.append(currentlyEditingSection)
      } else {
        // If note date differ from currently editing section date -> we need to configure new section with new date and put this new section in the sections array.
        dateForSection = noteDate.ddMMyy
        notesForSection = notesGroupedByDate[dateForSection]

        currentlyEditingSection = DiarySection(date: noteDate, notes: notesForSection ?? [])
        currentlyEditingSection.average = getAverageForSection(with: notesForSection)
        sectionsWithNotes.append(currentlyEditingSection)
      }
    }
  }

  private func getAverageForSection(with notes: [Note]?) -> String? {
    guard let notes = notes else { return nil }
    guard notes.count > 1 else { return nil }
    let mathHelper = MathHelper()
    var totalScore: Double = 0
    var totalNotes: Double = 0

    for note in notes {
      guard let average = note.mood?.average else { continue }
      totalScore += average
      totalNotes += 1.0
    }

    let averageScore = totalScore / totalNotes
    return mathHelper.getMoodScore(from: averageScore, digits: 1)
  }

}
