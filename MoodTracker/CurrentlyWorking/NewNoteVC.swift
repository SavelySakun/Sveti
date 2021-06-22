import UIKit

class NewNoteVC: UIViewController {

	let viewModel = ViewControllerVM(tableDataProvider: NewNoteTableDataProvider())

  lazy var tableView = TableView(sections: (viewModel.tableDataProvider?.sections)!)

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
