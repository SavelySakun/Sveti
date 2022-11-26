import Foundation

protocol IStatContentManager {
    associatedtype T
    func getStatContent() -> T
}
