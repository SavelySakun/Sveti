import XCTest
@testable import Sveti

class StatStateManagerTest: XCTestCase {

  private let sut = StatStateManager()
  private let statDaysRepository = StatDaysRepository()
  private let notesRepository = NotesRepository()

  private lazy var statTestHelper = StatTestHelper()
  private lazy var defaultNote: Note = statTestHelper.defaultNote
  private lazy var defaultStatDay: StatDay = statTestHelper.defaultStatDay
  
  override func setUpWithError() throws {
    notesRepository.save(defaultNote)
    statDaysRepository.saveNewStatDay(statDay: defaultStatDay)
  }
  
  override func tearDownWithError() throws {
    statDaysRepository.removeAll()
  }

  func testSaveStat() throws {
    statDaysRepository.removeAll()
    let statDay = statDaysRepository.getStatDay(with: statTestHelper.defaultDate)
    XCTAssertNil(statDay, "Already have saved statDay.")

    sut.saveStat(with: defaultNote)

    let newStatDay = statDaysRepository.getStatDay(with: statTestHelper.defaultDate)
    XCTAssertNotNil(newStatDay, "Can't find saved statDay.")
  }
  
  func testUpdateStat() throws {
    let phyzicalStatesCount = getCountOfPhyzicalStatesOfDefaultStatDay()
    sut.updateStat(with: defaultNote)
    let updatedPhyzicalStatesCount = getCountOfPhyzicalStatesOfDefaultStatDay()
    XCTAssertEqual(updatedPhyzicalStatesCount! - phyzicalStatesCount!, 1, "StatDay didn't update.")
  }

  func testRemoveStat() throws {
    let phyzicalStatesCount = getCountOfPhyzicalStatesOfDefaultStatDay()
    sut.removeStat(with: defaultNote.id)
    let updatedPhyzicalStatesCount = getCountOfPhyzicalStatesOfDefaultStatDay()
    XCTAssertEqual(phyzicalStatesCount! - updatedPhyzicalStatesCount!, 1, "StatDay didn't update.")
  }

  func testGetNewStatDay() throws {
    let statDay = sut.getNewStatDay(from: defaultNote)
    checkStatDayCorrectness(statDay)
  }

  func checkStatDayCorrectness(_ statDay: StatDay, file: StaticString = #file, line: UInt = #line) {
    XCTAssert(statDay.date == defaultNote.splitDate!.ddMMyyyy, "StatDay's date is incorrect", file: file, line: line)
    XCTAssert(statDay.totalNotes == 1, "StatDay's total notes is incorrect", file: file, line: line)
    XCTAssert(statDay.emotionalStates.contains(2.0), "StatDay doesn't contain correct emotional state.", file: file, line: line)
    XCTAssert(statDay.phyzicalStates.contains(2.0), "StatDay doesn't contain correct emotional state.", file: file, line: line)
  }

  func getCountOfPhyzicalStatesOfDefaultStatDay() -> Int? {
    let defaultStatDay = statDaysRepository.getStatDay(with: statTestHelper.defaultDate)
    return defaultStatDay?.phyzicalStates.count
  }
}
