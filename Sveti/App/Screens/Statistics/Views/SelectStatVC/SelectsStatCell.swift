import Foundation

class SelectsStatCell: SelectGroupCell {

  override func configureSelf(with viewModel: CellVM) {
    guard let statType = viewModel.cellValue as? StatTypes else { return }
    titleLabel.text = statType.getStatTypeDescription()
    let currentStatType = StatSettingsRepository().settings.statType
    accessoryType = (currentStatType == statType) ? .checkmark : .none
  }
}
