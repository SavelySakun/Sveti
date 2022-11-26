import Foundation

class SelectsStatCell: SelectGroupCell {
    override func configureSelf(with viewModel: CellVM) {
        guard let statType = viewModel.cellValue as? StatType else { return }
        titleLabel.text = statType.getDescription()
        let currentStatType = StatSettingsRepository().settings.statType
        accessoryType = (currentStatType == statType) ? .checkmark : .none
    }
}
