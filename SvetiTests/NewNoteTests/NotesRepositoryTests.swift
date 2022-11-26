@testable import Sveti
import XCTest

class NotesRepositoryTests: XCTestCase {
    let sut = NotesRepository()
    let note = Note()

    override func setUpWithError() throws {
        note.id = 1
    }

    override func tearDownWithError() throws {
        sut.removeAll()
    }

    func testRemoveAll() {
        sut.save(note)
        var totalSavedNotes = sut.getNotes().count
        XCTAssertTrue(totalSavedNotes > 0)
        sut.removeAll()
        totalSavedNotes = sut.getNotes().count
        XCTAssertTrue(totalSavedNotes == 0)
    }

    func testSave() {
        var totalSavedNotes = sut.getNotes().count
        XCTAssertTrue(totalSavedNotes == 0)
        sut.save(note)
        totalSavedNotes = sut.getNotes().count
        XCTAssertTrue(totalSavedNotes > 0)
    }

    func testGetNotes() {
        sut.save(note)
        let savedNotes = sut.getNotes()
        XCTAssertNotNil(savedNotes)
    }
}
