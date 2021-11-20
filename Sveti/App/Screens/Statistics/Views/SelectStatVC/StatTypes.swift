import Foundation
import RealmSwift

@objc enum StatTypes: Int, RealmEnum {
  case averageEmotional
  case averagePhysical
  case averageEmotionalAndPhysical

  func getStatTypeDescription() -> String {
    switch self {
    case .averageEmotional:
      return "Emotional 💚"
    case .averagePhysical:
      return "Physical ✊"
    case .averageEmotionalAndPhysical:
      return "Emotional & physical 🌿"
    }
  }
}
