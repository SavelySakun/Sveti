import Foundation
import RealmSwift

// Help info about migration: https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html#migrations

class RealmHelper {

  static let shared = RealmHelper()
  private let schemaVersion: UInt64 = 0

  func configureRealm() {
    let config = Realm.Configuration(
      schemaVersion: self.schemaVersion,
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < self.schemaVersion) {
          // Nothing to do!
        }
      })

    Realm.Configuration.defaultConfiguration = config
    let _ = try! Realm()
  }
}
