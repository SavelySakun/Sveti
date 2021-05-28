import UIKit

class NewNoteVC: UIViewController {

	let tableView = NewNoteTableView(frame: .zero, style: .insetGrouped)

	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()
	}

	private func setLayout() {
		view.backgroundColor = .yellow
		addTitle()
		addTableView()
	}

	private func addTitle() {
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Новая запись"
	}

	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct InfoVCPreview: PreviewProvider {

		static var previews: some View {
				// view controller using programmatic UI
				NewNoteVC().toPreview()
		}
}
#endif
