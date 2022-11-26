import Foundation
import UIKit

class TouchableSimpleCell: SimpleCell {
    override func setLayout() {
        super.setLayout()
        selectionStyle = .none
    }

    override func configureSelf(with viewModel: CellVM) {
        super.configureSelf(with: viewModel)
        addGesture()
    }

    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onAccessoryTap))
        addGestureRecognizer(gesture)
    }

    @objc private func onAccessoryTap() {
        onTapAction?(publisher)
    }
}
