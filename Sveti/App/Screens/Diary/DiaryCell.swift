import UIKit

class DiaryCell: Cell {

  private let scoreTimeView = ScoreTimeView()
  private let commentLabel = UILabel()
  private let containerView = UIView()
  private let tagCollectionView = DiaryTagCollectionView()

  func configure(with note: Note) {
    commentLabel.text = note.comment
    scoreTimeView.configure(with: note)
    containerView.backgroundColor = ColorHelper().getColor(value: MathHelper().getAverageMood(from: note), palette: .background)
    setTagCollection(with: note)
  }

  private func setTagCollection(with note: Note) {
    tagCollectionView.tags = Array(note.tags)
    DispatchQueue.main.async {
      self.tagCollectionView.reloadData()
    }
  }

  override func setLayout() {
    self.selectionStyle = .none
    setContainer()
    setScoreTime()
    setComment()
    setTagCollectionView()
  }

  private func setContainer() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 22
    containerView.backgroundColor = .systemGray6
    containerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(6)
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
      make.bottom.equalToSuperview().offset(-6)
    }
  }

  private func setScoreTime() {
    containerView.addSubview(scoreTimeView)
    scoreTimeView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.middleOffset)
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
    }
  }

  private func setComment() {
    commentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    commentLabel.numberOfLines = 0

    containerView.addSubview(commentLabel)
    commentLabel.snp.makeConstraints { (make) in
      make.top.equalTo(scoreTimeView.snp.bottom).offset(8)
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.right.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }

  private func setTagCollectionView() {
    containerView.addSubview(tagCollectionView)
    tagCollectionView.snp.makeConstraints { (make) in
      make.height.equalTo(25) // todo: сделать автовысоту
      make.top.equalTo(commentLabel.snp.bottom).offset(8)
      make.left.equalToSuperview().offset(9)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }
}
