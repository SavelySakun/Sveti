import UIKit

class ContactDeveloperVC: VCwithScrollView {

  private let mailButton = UIButton()
  private let telegramButton = UIButton()
  private let textImageView = ImageTextView(imageName: "purrDate", text: "Write information about bugs or words of support.")

  override func setLayout() {
    super.setLayout()
    title = "Contact us"
    view.backgroundColor = .white
    setButtons()
    setTextImageView()
    setButtonsStackView()
  }

  private func setButtons() {
    mailButton.setTitle("Email", for: .normal)
    mailButton.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.4823529412, blue: 0.1333333333, alpha: 1)
    telegramButton.setTitle("Telegram", for: .normal)
    telegramButton.backgroundColor = #colorLiteral(red: 0, green: 0.5333333333, blue: 0.8, alpha: 1)
    [mailButton, telegramButton].forEach { button in
      button.layer.cornerRadius = 8
    }
  }

  private func setTextImageView() {
    contentView.addSubview(textImageView)
    textImageView.snp.makeConstraints { (make) in
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.3)
      make.top.equalToSuperview().offset(UIUtils.hugeOffset)
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
