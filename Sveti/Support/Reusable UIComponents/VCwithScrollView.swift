import UIKit

class VCwithScrollView: UIViewController {

  private let scrollView = UIScrollView()
  let contentView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }

  func setLayout() {
    addScrollView()
    addContentView()
  }

  private func addScrollView() {
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  private func addContentView() {
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.width.equalTo(view.snp.width)
    }
  }
}
