import UIKit

class SelectStatTableHeaderView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setLayout() {
    let imageTextView = ImageTextView(imageName: "catMath", text: "Select the type of average state to analyze".localized)
    addSubview(imageTextView)
    imageTextView.imageView.snp.makeConstraints { (make) in
      make.height.equalToSuperview().multipliedBy(0.6)
    }
    imageTextView.snp.makeConstraints { (make) in
      make.left.right.equalToSuperview().inset(UIUtils.bigOffset)
      make.top.equalToSuperview().offset(40)
      make.bottom.equalToSuperview()
    }
  }
}
