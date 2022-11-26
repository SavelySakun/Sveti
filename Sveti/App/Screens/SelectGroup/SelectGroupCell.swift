import UIKit

class SelectGroupCell: Cell {
    internal let titleLabel = UILabel()

    override func setLayout() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(titleLabel)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIUtils.middleOffset)
            make.left.right.equalToSuperview().inset(UIUtils.bigOffset)
        }
    }

    override func configureSelf(with viewModel: CellVM) {
        guard let cellData = viewModel.cellValue as? SelectGroupCellData else { return }
        titleLabel.text = cellData.title
    }
}
