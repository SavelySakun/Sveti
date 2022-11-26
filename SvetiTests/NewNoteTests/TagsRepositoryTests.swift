@testable import Sveti
import XCTest

// For all test cases used test tag groups (DefaultTags class).
class TagsRepositoryTests: XCTestCase {
    private var sut = TagsRepository()
    private let userDefaults = UserDefaults()
    private lazy var isSaved = userDefaults.bool(forKey: UDKeys.isDefaultTagsSaved)

    override func setUpWithError() throws {
        sut.saveDefaultTags()
    }

    override func tearDownWithError() throws {
        userDefaults.setValue(false, forKey: UDKeys.isDefaultTagsSaved)
        sut.removeAll()
    }

    func testSetupDefaults() {
        XCTAssertNotNil(isSaved)
    }

    func testSaveDefaultTags() {
        let tagHealthGroup = sut.getGroup(withId: "health")
        let tagActivityGroup = sut.getGroup(withId: "activity")
        XCTAssertNotNil(tagHealthGroup)
        XCTAssertNotNil(tagActivityGroup)
    }

    func testFindTagWithId() {
        let goodTag = sut.findTag(withId: "1")
        XCTAssertNotNil(goodTag)
    }

    func testGetTagsWithName() {
        let badTag = sut.getTags(withName: "bad")
        XCTAssertNotNil(badTag)
    }

    func testUpdateExpandStatus() {
        let groupTrueExpandStatus = sut.groups[0].isExpanded
        sut.updateExpandStatus(groupIndex: 0)
        let groupFalseExpandStatus = sut.groups[0].isExpanded
        XCTAssertNotEqual(groupTrueExpandStatus, groupFalseExpandStatus)
    }

    func testFindGroupId() {
        let healthGroupId = sut.findGroupId(withIndex: 0)
        XCTAssertEqual(healthGroupId, "health")
    }

    func testGetGroupWithId() {
        let activityGroup = sut.getGroup(withId: "activity")
        XCTAssertNotNil(activityGroup)
    }

    func testUpdateTagHiddenStatus() {
        let tagFalseHiddenStatus = sut.findTag(withId: "1")?.isHidden ?? false
        sut.updateTagHiddenStatus(withId: "1")
        let tagTrueHiddenStatus = sut.findTag(withId: "1")?.isHidden ?? false
        XCTAssertNotEqual(tagFalseHiddenStatus, tagTrueHiddenStatus)
    }

    func testGetActiveTagsCountInSection() {
        let activeTagsCount = sut.getActiveTagsCount(in: 0)
        XCTAssertEqual(activeTagsCount, 2)
    }

    func testGetActiveTagsInSection() {
        let defaultActiveTagsInHealthSection = [Tag(name: "good", id: "1"), Tag(name: "bad", id: "2")]
        let activeTagsInHealthSection = sut.getActiveTags(in: 0)

        XCTAssertEqual(defaultActiveTagsInHealthSection[0].id, activeTagsInHealthSection[0].id)
        XCTAssertEqual(defaultActiveTagsInHealthSection[1].name, activeTagsInHealthSection[1].name)
    }

    func testRenameTagWithId() {
        let defaultTagName = "good"
        let newTagName = "A"
        sut.renameTag(withId: "1", newName: newTagName)
        let renamedTag = sut.findTag(withId: "1")

        XCTAssertNotEqual(defaultTagName, renamedTag?.name ?? "")
        XCTAssertEqual(newTagName, renamedTag?.name ?? "")
    }

    func testRemoveTagWithId() {
        let existingTag = sut.findTag(withId: "1")
        XCTAssertNotNil(existingTag)
        sut.removeTag(withId: "1")
        XCTAssertNil(sut.findTag(withId: "1"))
    }

    func testMoveTagToNewGroup() {
        let defaultHealthGroupCount = sut.getActiveTagsCount(in: 0)
        sut.moveTagTo(newGroupId: "activity", tagId: "1")
        let newHealthGroupCount = sut.getActiveTagsCount(in: 0)

        XCTAssertNotEqual(defaultHealthGroupCount, newHealthGroupCount)
        XCTAssertEqual(sut.groups[1].tags[0].name, "read")
    }

    func testAddNewTag() {
        let defaultHealthGroupCount = sut.getActiveTagsCount(in: 0)
        sut.addNewTag(withName: "A", groupId: "health")
        let updatedGroupCount = sut.getActiveTagsCount(in: 0)
        XCTAssertNotEqual(defaultHealthGroupCount, updatedGroupCount)
    }

    func testDeleteGroup() {
        sut.deleteGroup(with: "health")
        XCTAssertEqual(sut.groups.count, 1)
    }

    func testReorder() {
        let tagOnFirstIndex = sut.groups[0].tags[0]
        sut.reorder(moveRowAt: IndexPath(row: 0, section: 0), to: IndexPath(row: 1, section: 0), groupId: "health")
        let tagOnFirstIndexAfterReorder = sut.groups[0].tags[0]
        XCTAssertNotEqual(tagOnFirstIndex, tagOnFirstIndexAfterReorder)
    }

    func testRenameGroup() {
        let oldGroupName = sut.groups[0].title
        sut.renameGroup(with: "health", newName: "ABC")
        let newGroupName = sut.groups[0].title
        XCTAssertNotEqual(oldGroupName, newGroupName)
    }

    func testAddNewGroup() {
        let groupCount = sut.groups.count
        sut.addNewGroup(withName: "Test", id: "test")
        let newGroupCount = sut.groups.count
        XCTAssertNotEqual(groupCount, newGroupCount)
        XCTAssertEqual(newGroupCount - groupCount, 1)
    }

    func testReorderGroup() {
        let firstIndexGroupTitle = sut.groups[0].title
        sut.reorderGroup(moveGroupAt: IndexPath(row: 0, section: 0), to: IndexPath(row: 1, section: 0))
        let newFirstIndexGroupTitle = sut.groups[0].title
        XCTAssertNotEqual(firstIndexGroupTitle, newFirstIndexGroupTitle)
    }

    func testRemoveAll() {
        sut.removeAll()
        let healthGroup = sut.getGroup(withId: "health")
        XCTAssertNil(healthGroup)
    }
}
