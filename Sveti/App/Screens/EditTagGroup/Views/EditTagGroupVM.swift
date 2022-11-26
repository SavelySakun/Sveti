import Foundation

class EditTagGroupVM: ViewControllerVM {
    private let tagsRepository = TagsRepository()
    private let tagGroupId: String

    init(tableDataProvider: TableDataProvider, tagGroupId: String) {
        self.tagGroupId = tagGroupId
        super.init(tableDataProvider: tableDataProvider)
        generateCellsDataForTags()
    }

    func generateCellsDataForTags() {
        guard let group = tagsRepository.getGroup(withId: tagGroupId) else { return }
        var tagsData = [CellData]()
        var hiddenTagsData = [CellData]()

        group.tags.forEach { tag in
            if tag.isHidden {
                hiddenTagsData.append(CellData(type: TagGroupCell.self, viewModel: CellVM(cellValue: tag)))
            } else {
                tagsData.append(CellData(type: TagGroupCell.self, viewModel: CellVM(cellValue: tag)))
            }
        }

        tableDataProvider?.sections?[1].cellsData = tagsData
        tableDataProvider?.sections?[2].cellsData = hiddenTagsData
    }
}
