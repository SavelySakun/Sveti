import XCTest
import RealmSwift
@testable import Sveti

class StatDaysRepositoryTests: XCTestCase {

  private let sut = StatDaysRepository()

  private let defaultDate = "01.01.2021"
  private let testDate = "10.02.2021"
  private lazy var defaultStatDay: StatDay = {
    let statDay = StatDay()
    statDay.date = defaultDate
    statDay.phyzicalStates.append(objectsIn: [1.0, 2.0])
    statDay.emotionalStates.append(objectsIn: [1.0, 2.0])
    statDay.totalNotes = 2.0
    return statDay
  }()

  private let defaultNote: Note = {
    let note = Note()
    let date = Date(timeIntervalSince1970: 1609459200) // "01.01.2021"
    note.splitDate?.rawDate = date
    note.mood?.physicalState = 2.0
    note.mood?.emotionalState = 2.0
    return note
  }()

  override func setUpWithError() throws {
    sut.saveNewStatDay(statDay: defaultStatDay)
  }

  override func tearDownWithError() throws {
    sut.removeAll()
  }

  func testGetStatDay() throws {
    let statDay = sut.getStatDay(with: defaultDate)
    XCTAssertNotNil(statDay, "Can't find default statDay.")
  }

  func testAddDataToExistingStatDay() throws {
    let statDayFromRepository = sut.getStatDay(with: defaultDate)
    let phyzicalStateCount = statDayFromRepository?.phyzicalStates.count
    sut.addDataToExistingStatDay(with: defaultStatDay, note: defaultNote)
    let afterAddingInfoPhyzicalStateCount = statDayFromRepository?.phyzicalStates.count
    XCTAssertNotEqual(phyzicalStateCount, afterAddingInfoPhyzicalStateCount, "Didn't add new data to existing statDay.")
  }

  func testRemoveDataFromExistingStatDay() throws {
    let statDayFromRepository = sut.getStatDay(with: defaultDate)
    let phyzicalStateCount = statDayFromRepository?.phyzicalStates.count

    sut.removeDataFromExistingStatDay(with: defaultStatDay, note: defaultNote)

    let phyzicalStateCountAfterDelete = statDayFromRepository?.phyzicalStates.count

    guard let countBefore = phyzicalStateCount,
          let countAfter = phyzicalStateCountAfterDelete else { return }

    XCTAssertTrue(countAfter < countBefore, "Deletion of statistics about state doesn't happened.")
  }

  func testRemoveIfNoData() throws {
    let statDayWithNoStates = StatDay()
    statDayWithNoStates.date = testDate
    let initialStatDayCount = sut.getSavedObjectsCount()

    sut.saveNewStatDay(statDay: statDayWithNoStates)
    let countAfterSaving = sut.getSavedObjectsCount()
    XCTAssertTrue(initialStatDayCount < countAfterSaving, "There is an error with adding new statDay.")

    sut.removeIfNoData(statDay: statDayWithNoStates)
    let countAfterRemoveEmptyStatDay = sut.getSavedObjectsCount()
    XCTAssertTrue(countAfterRemoveEmptyStatDay == initialStatDayCount, "Remove empty statDay doesn't work.")
  }

  func testSaveNewStatDay() throws {
    let newStatDay = StatDay()
    newStatDay.date = testDate // different date as opposed to default
    let currentSavedCount = sut.getSavedObjectsCount()

    sut.saveNewStatDay(statDay: newStatDay)
    let afterSaveCount = sut.getSavedObjectsCount()

    XCTAssertTrue((afterSaveCount - currentSavedCount) == 1, "More than one new object saved in Realm or doesn't save any new at all.")
  }

  func testRemoveAll() throws {
    XCTAssertTrue(sut.isHaveSavedObjects(), "Realm doesn't have any saved StatDay objects.")
    sut.removeAll()
    XCTAssertFalse(sut.isHaveSavedObjects(), "Have saved object after remove all.")
  }
}
