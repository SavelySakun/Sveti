import UIKit

class ContactDeveloperVC: VCwithScrollView {
  private let textImageView = ImageTextView()
  private var mailButton: ButtonWithImage!
  private var telegramButton: ButtonWithImage!

  override func setLayout() {
    super.setLayout()
    title = "Contact us"
    view.backgroundColor = .white
    setButtons()
    setTextImageView()
    setButtonsStackView()
  }

  private func setButtons() {
    mailButton = getContactButton(title: "Email", imageName: "mail", color: #colorLiteral(red: 0.9882352941, green: 0.4823529412, blue: 0.1333333333, alpha: 1))
    telegramButton = getContactButton(title: "Telegram", imageName: "telegram", color: #colorLiteral(red: 0, green: 0.5333333333, blue: 0.8, alpha: 1))
  }

  private func getContactButton(title: String, imageName: String, color: UIColor) -> ButtonWithImage {
    let button = ButtonWithImage()
    button.setTitle(title, for: .normal)
    button.backgroundColor = color
    button.setImage(image: UIImage(named: imageName), size: 18)
    button.layer.cornerRadius = 8
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return button
  }

  private func setTextImageView() {
    contentView.addSubview(textImageView)
    textImageView.setContent(imageName: "purrDate", text: "Write information about bugs or words of support.")
    textImageView.snp.makeConstraints { (make) in
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.3)
      make.top.equalToSuperview().offset(UIUtils.kongOffset)
      make.centerX.equalToSuperview()
    }
  }

  private func setButtonsStackView() {
    let buttonsStackView = UIStackView(arrangedSubviews: [telegramButton, mailButton])
    buttonsStackView.axis = .vertical
    buttonsStackView.spacing = 8
    buttonsStackView.distribution = .fillProportionally

    contentView.addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { (make) in
      make.width.equalToSuperview().multipliedBy(0.8)
      make.height.equalTo(90)
      make.top.equalTo(textImageView.snp.bottom).offset(UIUtils.bigOffset)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

}
