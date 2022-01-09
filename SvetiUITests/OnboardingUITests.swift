import XCTest

class OnboardingUITests: XCTestCase {

  private let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launchEnvironment = ["test_mode": "true"]
    app.launch()
  }

  func testOnboardingContentViewExist() {
    XCTAssertTrue(app.otherElements["onboardingContentView"].exists)
  }

  func testGlobalBackgroundExist() {
    XCTAssertTrue(app.otherElements["globalBackgroundView"].exists)
  }

  func testImageWithBackgroundExist() {
    XCTAssertTrue(app.otherElements["imageWithBackground"].exists)
  }

  func testProgressViewExist() {
    XCTAssertTrue(app.progressIndicators["progressView"].firstMatch.exists)
  }

  func testTitleLabelExist() {
    XCTAssertTrue(app.staticTexts["titleLabel"].exists)
  }

  func testSubtitleLabelExist() {
    XCTAssertTrue(app.staticTexts["subtitleLabel"].exists)
  }

  func testNextButtonExist() {
    XCTAssertTrue(app.buttons["nextButton"].firstMatch.exists)
  }

  func testNoBackButtonOnFirstSlide() {
    XCTAssertFalse(app.buttons["backButton"].firstMatch.exists)
  }

  func testShowBackButtonOnSecondSlide() {
    app.buttons["nextButton"].firstMatch.tap()
    XCTAssertTrue(app.buttons["backButton"].firstMatch.exists)
  }

  func testDoneButtonOnLastSlide() {
    app.buttons["nextButton"].firstMatch.tap()
    XCTAssertTrue(app.buttons["buttonDone"].firstMatch.exists)
  }

  func testProgressChange() {
    XCTAssertTrue(app.progressIndicators["progressView"].firstMatch.exists)
    app.buttons["nextButton"].firstMatch.tap()
    XCTAssertTrue(app.progressIndicators["fullProgressView"].firstMatch.exists)
  }

  func testTextsChangeOnNextSlide() {
    let titleLabel = app.staticTexts["titleLabel"].firstMatch
    let subtitleLabel = app.staticTexts["subtitleLabel"].firstMatch

    XCTAssertEqual(titleLabel.label, "title1")
    XCTAssertEqual(subtitleLabel.label, "subtitle1")

    app.buttons["nextButton"].firstMatch.tap()

    XCTAssertEqual(titleLabel.label, "title2")
    XCTAssertEqual(subtitleLabel.label, "subtitle2")
  }

  func testBackButtonWorks() {
    let titleLabel = app.staticTexts["titleLabel"].firstMatch

    app.buttons["nextButton"].firstMatch.tap()
    XCTAssertEqual(titleLabel.label, "title2")

    app.buttons["backButton"].firstMatch.tap()
    XCTAssertEqual(titleLabel.label, "title1")
  }

  func testDoneButtonClosesOnboarding() {
    XCTAssertTrue(app.progressIndicators["progressView"].firstMatch.exists)
    app.buttons["nextButton"].firstMatch.tap()
    app.buttons["buttonDone"].firstMatch.tap()
    XCTAssertFalse(app.progressIndicators["progressView"].firstMatch.exists)
  }

  func testNavBarCloseButtonClosesOnboarding() {
    XCTAssertTrue(app.progressIndicators["progressView"].firstMatch.exists)
    let closeButton = app.navigationBars.children(matching: .button).firstMatch
    closeButton.tap()
    XCTAssertFalse(app.progressIndicators["progressView"].firstMatch.exists)
  }
}
