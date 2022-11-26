import UIKit

class DetailStatCell: Cell {
    private lazy var detailStatCollectionView = DetailStatCollectionView(frame: frame)

    override func setLayout() {
        super.setLayout()
        setCollection()
    }

    private func setCollection() {
        contentView.addSubview(detailStatCollectionView)
    }

    override func configureSelf(with viewModel: CellVM) {
        guard let detailStatItems = viewModel.cellValue as? [DetailStatItem] else { return }
        detailStatCollectionView.items = detailStatItems
        detailStatCollectionView.reloadData()
        updateCollectionLayout()
    }

    private func updateCollectionLayout() {
        detailStatCollectionView.layoutIfNeeded()
        let height = detailStatCollectionView.collectionViewLayout.collectionViewContentSize.height

        detailStatCollectionView.snp.removeConstraints()
        detailStatCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}
