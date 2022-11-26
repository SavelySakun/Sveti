import UIKit

class DetailNoteCommentCell: Cell {
    let textView = UITextView()
    let containerView = UIView()

    override func configureSelf(with viewModel: CellVM) {
        super.configureSelf(with: viewModel)
        guard let note = viewModel.cellValue as? Note else { return }
        textView.text = note.comment
    }

    override func setLayout() {
        contentView.backgroundColor = .systemGray6
        addContainer()
        addTextView()
    }

    private func addContainer() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func addTextView() {
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .systemGray6

        containerView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
        }
    }
}
