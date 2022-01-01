import XCTest
@testable import Sveti

class StatDaysDataSetGeneratorTests: XCTestCase {

  let contentManager = StatDayContentManager()

  // DataSet generation tests
  // Naming convention for dataSet generation: test_add_notesCount_note_groupingType_correctness

  // Days
  func test_add_1_note_days_correctness() {

  }

  func test_add_3_notes_days_correctness() {

  }

  // Weeks
  func test_add_1_note_week_correctness() {

  }

  func test_add_3_notes_week_correctness() {

  }

  // Month
  func test_add_1_note_month_correctness() {

  }

  func test_add_3_notes_month_correctness() {

  }

  func test_add_12_notes_month_correctness() {

  }

  // Year
  func test_add_1_note_year_correctness() {

  }

  func test_add_3_notes_year_correctness() {

  }

  private func addNoteAndUpdateStats(noteDate: String) {
    let note = Note()
    note.splitDate = SplitDate(ddMMyyyy: noteDate)
    NotesRepository().save(note)
    StatDaysDataManager().updateStat(with: note)
  }

}
