//
//  NewNoteUITests.swift
//  SvetiUITests
//
//  Created by Savely Sakun on 04.09.2021.
//

import XCTest

class NewNoteUITests: XCTestCase {

  let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
    app.tabBars["Tab Bar"].buttons["Новая запись"].tap()
  }

  override func tearDownWithError() throws {
  }

  func testTagCellExist() throws {
    let tagCell = app.cells.element(matching: .cell, identifier: "tag-cell")
    XCTAssert(tagCell.exists)
  }

  func testMoveToGroupEditScreen() throws {
    app.tables.cells["tag-cell"].children(matching: .button).matching(identifier: "edit").element(boundBy: 3).tap()
    app.navigationBars["Изменить"].buttons["Новая запись"].tap()
  }

}
