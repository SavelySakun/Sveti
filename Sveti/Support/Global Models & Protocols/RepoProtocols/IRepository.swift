import Foundation
import RealmSwift

protocol IRepository {
    associatedtype T
    var realm: Realm { get set }

    func get() -> T
    func save(object: Object)
}
