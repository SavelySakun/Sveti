import UIKit

class DeleteTableFooter: UIView {

  var onDeleteTapHandler: (() -> Void) = { return }
  let deleteButton = UIButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    deleteButton.setTitle("Delete".localized, for: .normal)
    deleteButton.setTitleColor(.systemRed, for: .normal)
    deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)

    deleteButton.layer.borderWidth = 1
    deleteButton.layer.borderColor = UIColor.systemRed.cgColor
    deleteButton.layer.cornerRadius = 12
    deleteButton.addTarget(self, action: #selector(onDeleteTap), for: .touchUpInside)

    addSubview(deleteButton)
    deleteButton.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.bigOffset)
      make.bottom.right.equalToSuperview().offset(-UIUtils.bigOffset)
    }
  }

  @objc private func onDeleteTap() {
    onDeleteTapHandler()
  }
}
