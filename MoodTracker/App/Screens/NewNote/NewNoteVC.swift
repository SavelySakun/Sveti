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
		view.backgroundColor = .yellow
		setNavigationBar()
		addTableView()
    setSaveButton()
    configureSaveAlert()
    configureClearAlert()
	}

	private func setNavigationBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Новая запись"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(onClearTap))
  }

  private func setSaveButton() {
    let saveButton = UIButton()
    saveButton.setTitle("Сохранить", for: .normal)
    saveButton.layer.cornerRadius = 12
    saveButton.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.8039215686, blue: 0.7058823529, alpha: 1)
    saveButton.addTarget(self, action: #selector(saveNewNote), for: .touchUpInside)

    view.addSubview(saveButton)
    saveButton.snp.makeConstraints { (make) in
      make.centerX.equalTo(view.snp.centerX)
      make.bottom.equalTo(view.snp.bottom).offset(-100)
      make.width.equalTo(view.frame.width / 2.5)
      make.height.equalTo(50)
    }
  }

  private func configureSaveAlert() {
    let okAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
      self.navigationController?.tabBarController?.selectedIndex = 0
      self.viewModel.saveCurrentNote()
      self.clearAllInput()
      SPIndicator.present(title: "Готово", message: nil, preset: .done, from: .center, completion: nil)
    }
    let noAction = UIAlertAction(title: "Отменить", style: .destructive, handler: nil)

    [okAction, noAction].forEach { action in
      saveAlert.addAction(action)
    }
  }

  private func configureClearAlert() {
    let okAction = UIAlertAction(title: "Очистить", style: .default) { _ in
      self.clearAllInput()
      SPIndicator.present(title: "Очищено", message: nil, preset: .done, from: .center, completion: nil)
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

  @objc private func saveNewNote() {
    present(saveAlert, animated: true, completion: nil)
  }

  @objc private func onClearTap() {
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
