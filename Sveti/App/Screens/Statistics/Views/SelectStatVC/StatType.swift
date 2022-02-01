import Foundation
import RealmSwift

@objc enum StatType: Int, RealmEnum {
  case emotional
  case physical
  case all

  func getDescription() -> String {
    switch self {
    case .emotional:
      return "Emotional 💚".localized
    case .physical:
      return "Physical ✊".localized
    case .all:
      return "Emotional & physical 🌿".localized
    }
  }
}
