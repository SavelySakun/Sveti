import MessageUI
import SPAlert
import UIKit

class ContactDeveloperVC: VCwithScrollView {
    private let textImageView = ImageTextView()
    private var mailButton: ButtonWithImage!
    private var telegramButton: ButtonWithImage!

    override func setLayout() {
        super.setLayout()
        title = "Contact us".localized
        view.backgroundColor = .systemGray6
        setButtons()
        setTextImageView()
        setButtonsStackView()
    }

    private func setButtons() {
        mailButton = getContactButton(title: "Email", imageName: "mail", color: #colorLiteral(red: 0.9882352941, green: 0.4823529412, blue: 0.1333333333, alpha: 1))
        mailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        telegramButton = getContactButton(title: "Telegram", imageName: "telegram", color: #colorLiteral(red: 0, green: 0.5333333333, blue: 0.8, alpha: 1))
        telegramButton.addTarget(self, action: #selector(redirectToTelegram), for: .touchUpInside)
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
        textImageView.setContent(imageName: "purrDate", text: "Share information about bugs or words of support".localized)
        textImageView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
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
        buttonsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(100)
            make.top.equalTo(textImageView.snp.bottom).offset(UIUtils.bigOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["sveti.contact@gmail.com"])
            mailVC.setSubject("Sveti Feedback".localized)
            present(mailVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Error".localized, message: "Sending an email is not supported. You need to set up mail".localized, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(dismiss)
            present(alert, animated: true)
        }
    }

    @objc private func redirectToTelegram() {
        guard let url = URL(string: "https://t.me/sveti_app") else { return }
        UIApplication.shared.open(url)
    }
}

extension ContactDeveloperVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error _: Error?) {
        controller.dismiss(animated: true)
        guard result == .sent else { return }
        SPAlert.present(message: "The email has been sent!".localized, haptic: .success)
    }
}
