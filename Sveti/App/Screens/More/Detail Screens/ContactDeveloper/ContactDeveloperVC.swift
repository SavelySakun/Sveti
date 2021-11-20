import UIKit

class ContactDeveloperVC: UIViewController {

  private let textImageView = ImageTextView(imageName: "purrDate", text: "Write information about bugs or words of support.")
  private let mailButton = UIButton()
  private let telegramButton = UIButton()

  // УНЕСТИ КОНТЕНТ В СКРОЛЛ ВЬЮ
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtons()
    setLayout()
  }

  private func setButtons() {
    mailButton.setTitle("e-mail", for: .normal)
    mailButton.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.4823529412, blue: 0.1333333333, alpha: 1)
//    mailButton.setImage(UIImage(named: "Calendar"), for: .normal)
    telegramButton.setTitle("Telegram", for: .normal)
    telegramButton.backgroundColor = #colorLiteral(red: 0, green: 0.5333333333, blue: 0.8, alpha: 1)
    [mailButton, telegramButton].forEach { button in
      button.layer.cornerRadius = 8
    }
  }

  private func setLayout() {
    title = "Contact us"
    view.backgroundColor = .white

    view.addSubview(textImageView)
    textImageView.snp.makeConstraints { (make) in
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.3)
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-80)
    }

    let buttonsStackView = UIStackView(arrangedSubviews: [telegramButton, mailButton])
    buttonsStackView.axis = .vertical
    buttonsStackView.spacing = 8
    buttonsStackView.distribution = .fillProportionally

    view.addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { (make) in
      make.top.equalTo(textImageView.snp.bottom).offset(24)
      make.width.equalToSuperview().multipliedBy(0.5)
      make.centerX.equalToSuperview()
      make.height.equalTo(100)
    }
  }
}
