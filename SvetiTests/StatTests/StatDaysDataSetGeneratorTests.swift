import XCTest
@testable import Sveti

class StatDaysDataSetGeneratorTests: XCTestCase {

  // DataSet generator is used in contentManger. We use contentManager in tests for easy data access
  let contentManager = StatDayContentManager()
  let notesRepository = NotesRepository()
  let statDaysDataManager = StatDaysDataManager()

  override func tearDownWithError() throws {
    notesRepository.removeAll()
    statDaysDataManager.removeAll()
  }

  // DataSet generation tests
  // Naming convention for dataSet generation: test_add_notesCount_note_groupingType_correctness

  // Days
  func test_add_1_note_days_correct_mood_value() {
    addNoteAndUpdateStats(noteDate: "01.01.2020", emotionalState: 6.0, physicalState: 6.0)
    let dataSet = contentManager.dataSet

    guard let lastEntry  = dataSet?.entries.last else {
      XCTFail("Last entry doesn't exist")
      return
    }

    XCTAssert(lastEntry.y == 6.0)
  }

  func test_add_1_note_days_has_entry() {
    addNoteAndUpdateStats(noteDate: "01.01.2020", emotionalState: 6.0, physicalState: 6.0)
    let dataSet = contentManager.dataSet

    guard let entries = dataSet?.entries else {
      XCTFail("Empty entries. Not valid")
      return
    }

    XCTAssertTrue(entries.count > 0)
  }

  func test_add_3_notes_in_one_day_correct_mood_value() {
    addNoteAndUpdateStats(noteDate: "01.01.2020")
    addNoteAndUpdateStats(noteDate: "01.01.2020", emotionalState: 5.0, physicalState: 5.0)
    addNoteAndUpdateStats(noteDate: "01.01.2020", emotionalState: 4.0, physicalState: 4.0)

    guard let lastCurrentlyDrawedStat = contentManager.currentlyDrawedStat?.last else {
      XCTFail("Empty currentlyDrawedStat. Not valid")
      return
    }

    XCTAssertTrue(lastCurrentlyDrawedStat.averageState == 5.0)
  }

  func test_add_3_notes_in_3_different_days_correct_drawedStat_count() {
    addNoteAndUpdateStats(noteDate: "01.01.2020")
    addNoteAndUpdateStats(noteDate: "02.01.2020")
    addNoteAndUpdateStats(noteDate: "03.01.2020")

    guard let currentlyDrawedStat = contentManager.currentlyDrawedStat else {
      XCTFail("Empty currentlyDrawedStat. Not valid")
      return
    }

    XCTAssertTrue(currentlyDrawedStat.count == 3)
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

  private func addNoteAndUpdateStats(noteDate: String, emotionalState: Double = 6.0, physicalState: Double = 6.0) {
    let note = Note()
    note.mood?.emotionalState = emotionalState
    note.mood?.physicalState = physicalState
    note.splitDate = SplitDate(ddMMyyyy: noteDate)
    notesRepository.save(note)
    statDaysDataManager.updateStat(with: note)
    contentManager.updateStatContent()
  }

}
