import UIKit

class NewNoteVC: UIViewController {

	let viewModel = NewNoteVM(tableDataProvider: NewNoteTableDataProvider())

  lazy var tableView = TableView(sections: (viewModel.tableDataProvider?.sections)!, viewModel: viewModel)

	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()

	}

	private func setLayout() {
		view.backgroundColor = .yellow
		setNavigationBar()
		addTableView()

	}

	private func setNavigationBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Новая запись"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveNewNote))
  }

	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

  @objc private func saveNewNote() {
    print(viewModel.note)
  }

}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct InfoVCPreview: PreviewProvider {
//
//		static var previews: some View {
//				// view controller using programmatic UI
//				NewNoteVC().toPreview()
//		}
//}
//#endif
