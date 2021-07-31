import UIKit
import SnapKit
import SPIndicator

class NewNoteVC: BaseViewController {

	let viewModel = NewNoteVM(tableDataProvider: NewNoteTableDataProvider())
  let saveAlert = UIAlertController(title: "Внимание", message: "Сохранить новую запись?", preferredStyle: .alert)
  let clearAlert = UIAlertController(title: "Внимание", message: "Очистить форму?", preferredStyle: .alert)

  lazy var tableView = TableView(sections: (viewModel.tableDataProvider?.sections)!, viewModel: viewModel)

	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()
	}

	private func setLayout() {
		setNavigationBar()
		addTableView()
    configureClearAlert()
	}

	private func setNavigationBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Новая запись"

    let leftButton = UIBarButtonItem(title: "Сбросить", style: .plain, target: self, action: #selector(onClear))
    leftButton.tintColor = .orange

    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(onSave))
  }

  private func configureClearAlert() {
    let okAction = UIAlertAction(title: "Очистить", style: .default) { _ in
      self.clearAllInput()
      SPIndicator.present(title: "Сброшено", message: nil, preset: .done, from: .center, completion: nil)
    }
    let noAction = UIAlertAction(title: "Отменить", style: .destructive, handler: nil)

    [okAction, noAction].forEach { action in
      clearAlert.addAction(action)
    }
  }

	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

  @objc private func onSave() {
    self.navigationController?.tabBarController?.selectedIndex = 0
    self.viewModel.saveCurrentNote()
    self.clearAllInput()
    if let diaryVC = self.navigationController?
        .tabBarController?
        .viewControllers?[0]
        .children.first as? DiaryVC {
      diaryVC.updateData()
    }
    SPIndicator.present(title: "Готово", message: nil, preset: .done, from: .center, completion: nil)
  }

  @objc private func onClear() {
    present(clearAlert, animated: true, completion: nil)
  }

  private func clearAllInput() {
    viewModel.clearInput()
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
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
