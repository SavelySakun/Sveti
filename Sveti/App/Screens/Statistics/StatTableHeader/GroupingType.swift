import Foundation
import RealmSwift

@objc enum GroupingType: Int, RealmEnum {
  case day = 0
  case week = 1
  case month = 2
  case year = 3
}
