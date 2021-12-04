import UIKit

class NoTagFound: Cell {

  private let noTagsView = ImageTextView(imageName: "surprise", text: "Please add at least 1 tag ✨")

  override func setLayout() {
    let backView = UIView()
    backView.backgroundColor = .systemGray6
    backView.layer.cornerRadius = 12
    contentView.addSubview(backView)
    backView.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview()
      make.right.left.equalToSuperview().inset(UIUtils.middleOffset)
    }

    backView.addSubview(noTagsView)
    let currentVCFrame = CurrentVC.current?.view.frame
    let widthHeight = (currentVCFrame?.width ?? 450) * 0.3
    noTagsView.imageView.snp.makeConstraints { (make) in
      make.width.height.equalTo(widthHeight)
    }
    noTagsView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(UIUtils.defaultOffset)
    }
  }
}
