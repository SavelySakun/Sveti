@testable import Sveti
import XCTest

class DrawableStatTests: XCTestCase {
    private let defaultStatDay = StatDay(phyzicalStates: [6.6, 7.1, 6, 10, 9.1, 7.1, 6.8, 7.2], emotionalStates: [1, 2.5, 9.9, 9.1, 3, 8, 6, 1.1])
    private let statDayTwo = StatDay(phyzicalStates: [5, 6, 9, 9, 4.5, 6, 5, 7], emotionalStates: [8, 7, 6, 5.2, 1, 4, 3, 8])
    private lazy var drawableStat = DrawableStat([defaultStatDay], Date())
    private lazy var manyDrawableStat = DrawableStat([statDayTwo, defaultStatDay], Date())

    func testAverages() {
        let avgPhyz = drawableStat.averageMood.get(.physical).round1f()
        let avgEmot = drawableStat.averageMood.get(.emotional).round1f()
        let avgAll = drawableStat.averageMood.get(.all).round1f()

        XCTAssertEqual(avgPhyz, 7.5)
        XCTAssertEqual(avgEmot, 5.1)
        XCTAssertEqual(avgAll, 6.3)
    }

    func testMax() {
        let maxPhyz = drawableStat.maxMood.get(.physical).round1f()
        let maxEmot = drawableStat.maxMood.get(.emotional).round1f()
        let maxAll = drawableStat.maxMood.get(.all).round1f()

        XCTAssertEqual(maxPhyz, 10)
        XCTAssertEqual(maxEmot, 9.9)
        XCTAssertEqual(maxAll, 9.6)
    }

    func testMin() {
        let minPhyz = drawableStat.minMood.get(.physical).round1f()
        let minEmot = drawableStat.minMood.get(.emotional).round1f()
        let minAll = drawableStat.minMood.get(.all).round1f()

        XCTAssertEqual(minPhyz, 6)
        XCTAssertEqual(minEmot, 1)
        XCTAssertEqual(minAll, 3.8)
    }

    func testStability() {
        let stabPhyz = drawableStat.stability?.get(.physical).round1f()
        let stabEmot = drawableStat.stability?.get(.emotional).round1f()
        let stabAll = drawableStat.stability?.get(.all).round1f()

        XCTAssertEqual(stabPhyz, 82)
        XCTAssertEqual(stabEmot, 28.5)
        XCTAssertEqual(stabAll, 68.1)
    }

    func testAverage_2StatDays() {
        let avgPhyz = manyDrawableStat.averageMood.get(.physical).round1f()
        let avgEmot = manyDrawableStat.averageMood.get(.emotional).round1f()
        let avgAll = manyDrawableStat.averageMood.get(.all).round1f()

        XCTAssertEqual(avgPhyz, 7)
        XCTAssertEqual(avgEmot, 5.2)
        XCTAssertEqual(avgAll, 6.1)
    }

    func testStability_2StatDays() {
        let stabPhyz = manyDrawableStat.stability?.get(.physical).round1f()
        let stabEmot = manyDrawableStat.stability?.get(.emotional).round1f()
        let stabAll = manyDrawableStat.stability?.get(.all).round1f()

        XCTAssertEqual(stabPhyz, 76.9)
        XCTAssertEqual(stabEmot, 41.9)
        XCTAssertEqual(stabAll, 69.8)
    }

    func testTotalNotes() {
        let manyStats = manyDrawableStat.totalNotes
        let defaultStats = defaultStatDay.totalNotes

        XCTAssertEqual(manyStats, 16)
        XCTAssertEqual(defaultStats, 8)
    }
}
