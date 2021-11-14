import Foundation

class SelectsStatCell: SelectGroupCell {
  override func configureSelf(with viewModel: CellVM) {
    titleLabel.text = viewModel.title
  }
}
