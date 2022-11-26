import Foundation
import SnapKit

struct OrientationConstraints {
    var portraitConstraints = [Constraint]()
    var horizontalConstraints = [Constraint]()

    func update() {
        if DeviceUtils.isPortraitOrientation {
            updateConstraints(constraintsToActivate: portraitConstraints, constraintsToDeactivate: horizontalConstraints)
        } else {
            updateConstraints(constraintsToActivate: horizontalConstraints, constraintsToDeactivate: portraitConstraints)
        }
    }

    private func updateConstraints(constraintsToActivate: [Constraint], constraintsToDeactivate: [Constraint]) {
        constraintsToActivate.forEach { constraint in
            constraint.activate()
        }
        constraintsToDeactivate.forEach { constraint in
            constraint.deactivate()
        }
    }
}
