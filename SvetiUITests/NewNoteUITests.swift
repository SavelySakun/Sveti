import XCTest

class NewNoteUITests: XCTestCase {

  private let app = XCUIApplication()
  private let testText = String(UUID().uuidString.prefix(4))

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
    app.tabBars["Tab Bar"].buttons["New note"].tap()
  }

  func testTagCellExist() throws {
    let tagCell = app.cells.element(matching: .cell, identifier: "tag-cell")
    XCTAssert(tagCell.exists)
  }

  func testMoveToGroupEditScreen() throws {
    app.tables.cells["tag-cell"].children(matching: .button).matching(identifier: "edit").element(boundBy: 4).tap()
    app.navigationBars["Edit"].buttons["New note"].tap()
  }

  func testCommentCellExist() throws {
    let commentCell = app.tables.cells["comment-cell"].firstMatch
    XCTAssert(commentCell.exists)
  }

  func testCommentCellWork() throws {
    let testText = self.testText
    let commentCell = app.tables.cells["comment-cell"].firstMatch
    let commentTextView = commentCell.children(matching: .textView).element
    XCTAssert(commentTextView.exists)
    commentTextView.tap()
    commentTextView.typeText(testText)
    app.navigationBars["New note"].buttons["Save"].tap()
    let comment = app.tables.staticTexts[testText]
    XCTAssert(comment.exists)
  }

  func testTagSelection() throws {
    let tagName = "movie"
    let tagCellInCollection = app.tables.staticTexts[tagName]
    XCTAssert(tagCellInCollection.exists)
    tagCellInCollection.tap()
    app.navigationBars["New note"].buttons["Save"].tap()
    let comment = app.tables.staticTexts[tagName]
    XCTAssert(comment.exists)
  }

  func testTagSearch() throws {
    app.tables/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".cells[\"tag-cell\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    mKey.tap()
    let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    oKey.tap()
    app.tables.cells["tag-cell"].children(matching: .staticText).matching(identifier: "movie").element(boundBy: 1).tap()
  }

  func testEmotionalPhysicalCellExist() throws {
    let emotionalCell = app.tables.cells["emotional-cell"]
    let physicalCell = app.tables.cells["physical-cell"]
    XCTAssert(emotionalCell.exists)
    XCTAssert(physicalCell.exists)
  }

  func testDateCellWork() throws {
    app.tables/*@START_MENU_TOKEN@*/.otherElements["Date and Time Picker"]/*[[".cells.otherElements[\"Date and Time Picker\"]",".otherElements[\"Date and Time Picker\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
  }

  func testAddNewTagInGroup() throws {
    let testText = self.testText
    app.tables.cells["tag-cell"].children(matching: .button).matching(identifier: "edit").element(boundBy: 4).tap()
    let editNavigationBar = app.navigationBars["Edit"]
    editNavigationBar.buttons["add"].tap()
    let textFieldInAlert = app.alerts["Add a tag"].scrollViews.otherElements.collectionViews.textFields["Tag name"]
    textFieldInAlert.tap()
    textFieldInAlert.typeText(testText)
    app.alerts["Add a tag"].scrollViews.otherElements.buttons["Add"].tap()
    editNavigationBar.buttons["New note"].tap()
    let newTag = app.tables.staticTexts[testText]
    XCTAssert(newTag.exists)
  }
}
