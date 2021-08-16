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
    guard let group = tagsRepository.getGroup(with: tagGroupId) else { return }
    var cellsData = [CellData]()

    group.tagIds.forEach { tagId in
      cellsData.append(CellData(type: TagGroupCell.self, viewModel: CellVM(cellValue: tagId)))
    }

    tableDataProvider?.sections?[1].cellsData = cellsData // do SAFE
  }

}
