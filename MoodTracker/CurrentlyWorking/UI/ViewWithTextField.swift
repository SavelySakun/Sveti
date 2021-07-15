import UIKit

class ViewWithTextField {

  var fieldView: UIView {
    let fieldView = UIView()
    fieldView.backgroundColor = .systemGray6
    fieldView.layer.cornerRadius = 12
    fieldView.contentMode = .scaleAspectFit
    return fieldView
  }

  var textField = UITextField()

}
