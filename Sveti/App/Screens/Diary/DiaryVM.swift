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
    StatDayContentManager.shared.needUpdateViews = true
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
    let mathHelper = SvetiMath()
    var totalScore: Double = 0
    var totalNotes: Double = 0

    for note in notes {
      guard let average = note.mood?.average else { continue }
      totalScore += average
      totalNotes += 1.0
    }

    let averageScore = totalScore / totalNotes
    return mathHelper.getString(from: averageScore, digits: 1)
  }

  func getDiaryTableSectionHeader(for section: Int) -> DiaryTableSectionHeader {

    var isSameYear = false // If current & previous section item have the same date -> don't show year string in the current section title.
    let sectionItem = sectionsWithNotes[section]

    if let nextSectionItem = sectionsWithNotes[safe: (section + 1)] {
      isSameYear = (nextSectionItem.date.MMYY == sectionItem.date.MMYY)
    }

    let itemDate = sectionItem.date
    let date = isSameYear ? itemDate.dMMMM : itemDate.dMMMMyyyy
    return DiaryTableSectionHeader(date: "\(itemDate.weekday.localizedCapitalized), \(date)", averageScore: sectionItem.average)
  }

}
