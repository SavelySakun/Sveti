import RealmSwift

extension List {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
