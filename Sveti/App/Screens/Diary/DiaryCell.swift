import TagListView
import UIKit

class DiaryCell: Cell {
    private let scoreTimeView = ScoreTimeView()
    private let commentLabel = UILabel()
    private let containerView = UIView()
    private let tagListView = SvetiTagListView()

    func configure(with note: Note) {
        commentLabel.text = note.comment
        scoreTimeView.configure(with: note)
        containerView.backgroundColor = ColorHelper().getColor(value: SvetiMath().getAverageMood(from: note), alpha: 0.65)
        contentView.backgroundColor = .systemGray6
        setTagListView(with: note)
    }

    private func setTagListView(with note: Note) {
        tagListView.setTags(from: note)

        tagListView.snp.updateConstraints { make in
            let offset = (commentLabel.text?.isEmpty ?? true) ? 0 : UIUtils.defaultOffset
            make.top.equalTo(commentLabel.snp.bottom).offset(offset)
        }
    }

    override func setLayout() {
        selectionStyle = .none
        setContainer()
        setScoreTime()
        setComment()
        setTagListViewLayout()
    }

    private func setContainer() {
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 14
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(15)
        }
    }

    private func setScoreTime() {
        containerView.addSubview(scoreTimeView)
        scoreTimeView.timeLabel.textColor = .white
        scoreTimeView.scoreLabel.textColor = .white
        scoreTimeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIUtils.middleOffset)
            make.left.equalToSuperview().offset(UIUtils.middleOffset)
        }
    }

    private func setComment() {
        commentLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        commentLabel.numberOfLines = 0
        commentLabel.textColor = .white

        containerView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreTimeView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(UIUtils.middleOffset)
        }
    }

    private func setTagListViewLayout() {
        containerView.addSubview(tagListView)
        tagListView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(UIUtils.defaultOffset)
            make.left.equalToSuperview().offset(UIUtils.middleOffset)
            make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
        }
    }
}
