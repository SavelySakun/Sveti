import UIKit

class NewNoteVC: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()
	}

	private func setLayout() {
		view.backgroundColor = .green
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
