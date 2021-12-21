import XCTest
@testable import Sveti

class SplitDateTests: XCTestCase {

  private let defaultDate = "21.12.2021"
  private lazy var sut = SplitDate(ddMMyyyy: defaultDate)
  private let dateFormatter = DateFormatter()

  func testRawDateInit() throws {
    let now = Date()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let ddMMyyyy = dateFormatter.string(from: now)
    let splitDate = SplitDate(rawDate: now)
    XCTAssertEqual(ddMMyyyy, splitDate.ddMMyyyy)
  }

  func testStringDateInit() throws {
    let testDate = "01.01.2000"
    let splitDate = SplitDate(ddMMyyyy: testDate)
    XCTAssertEqual(testDate, splitDate.ddMMyyyy)
  }

  func testGet_yyyy() throws {
    XCTAssertEqual("2021", sut.yyyy)
  }

  func testGet_HHmm() throws {
    let time = "13:14"
    dateFormatter.dateFormat = "HH:mm"
    let rawDate = dateFormatter.date(from: time) ?? Date()
    let splitDate = SplitDate(rawDate: rawDate)
    XCTAssertEqual(time, splitDate.HHmm)
  }

  func testGet_ddMMyyyy() throws {
    XCTAssertEqual(defaultDate, sut.ddMMyyyy)
  }

  func testGet_ddMMyy() throws {
    let testDate = "21.12.21"
    XCTAssertEqual(testDate, sut.ddMMyy)
  }

  func testGet_dMMMMyyyy() throws {
    let testDate = "21 December 2021"
    XCTAssertEqual(testDate, sut.dMMMMyyyy)
  }

  func testGet_dMM() throws {
    let testDate = "21.12"
    XCTAssertEqual(testDate, sut.dMM)
  }

  func testGet_MM() throws {
    let testDate = "12"
    XCTAssertEqual(testDate, sut.MM)
  }

  func testGet_MMYY() throws {
    let testDate = "12.21"
    XCTAssertEqual(testDate, sut.MMYY)
  }

  func testGet_weekday() throws {
    let testDate = "Tuesday"
    XCTAssertEqual(testDate, sut.weekday)
  }

  func testMeasure() throws {
    measure {
      try! testRawDateInit()
      try! testStringDateInit()
      try! testGet_yyyy()
      try! testGet_HHmm()
      try! testGet_ddMMyyyy()
      try! testGet_ddMMyy()
      try! testGet_dMMMMyyyy()
      try! testGet_dMM()
      try! testGet_MM()
      try! testGet_MMYY()
      try! testGet_weekday()
    }
  }
}
