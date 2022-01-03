import Foundation
import RealmSwift

@objc enum StatTypes: Int, RealmEnum {
  case averageEmotional
  case averagePhysical
  case averageEmotionalAndPhysical

  func getStatTypeDescription() -> String {
    switch self {
    case .averageEmotional:
      return "Emotional 💚".localized
    case .averagePhysical:
      return "Physical ✊".localized
    case .averageEmotionalAndPhysical:
      return "Emotional & physical 🌿".localized
    }
  }
}
