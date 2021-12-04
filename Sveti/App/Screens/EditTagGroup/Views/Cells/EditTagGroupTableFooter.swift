import UIKit

class EditTagGroupTableFooter: UIView {

  var onDeleteTapHandler: (() -> Void) = { return }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    let deleteButton = UIButton()
    deleteButton.setTitle("Delete group", for: .normal)
    deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    deleteButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.7)
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
