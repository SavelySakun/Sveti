import XCTest
import RealmSwift
@testable import Sveti

class StatDaysRepositoryTests: XCTestCase {

  private let sut = StatDaysRepository()
  private lazy var statTestHelper = StatTestHelper()

  private lazy var defaultDate = statTestHelper.defaultDate
  private lazy var testDate = statTestHelper.testDate
  private lazy var defaultStatDay: StatDay = statTestHelper.defaultStatDay
  private lazy var defaultNote: Note = statTestHelper.defaultNote

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
