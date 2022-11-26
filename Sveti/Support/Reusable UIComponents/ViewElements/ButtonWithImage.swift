import UIKit

class ButtonWithImage: UIButton {
    func setImage(image: UIImage?, size: Int) {
        guard let image = image else { return }
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white

        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            guard let titleLabel = self.titleLabel else { return }
            make.right.equalTo(titleLabel.snp.left).offset(-UIUtils.defaultOffset)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.height.equalTo(size)
        }
    }
}
