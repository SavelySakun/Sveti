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

  override func handle<T>(_ event: T) where T: Event {
    guard let event = event as? TagEvent else { return }
    let eventType = TagEditType(rawValue: event.type)
    let tagId = event.value as? String ?? ""
    switch eventType {
    case .delete:
      print("УДАЛИЛ")
    case .hide:
      hideTag(with: tagId)
    case .show:
      print("ПОКАЗАЛ")
    default:
      return
    }
  }

  private func hideTag(with tagId: String) {
    print("Обновил видимость: \(tagId)")
    subscribers.removeAll()
    tagsRepository.updateTagHiddenStatus(with: tagId)
    delegate?.onNeedToUpdateContent()
  }

}
