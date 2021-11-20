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
    let imageView = ImageTextView(imageName: "catMath", text: "Select the type of average state to analyze.")
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.left.right.equalToSuperview().inset(UIUtils.bigOffset * 2)
      make.top.equalToSuperview().offset(40)
      make.bottom.equalToSuperview()
    }
  }
}
