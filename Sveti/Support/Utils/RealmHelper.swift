import Foundation
import RealmSwift

// Help info about migration: https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html#migrations

class RealmHelper {

  private let schemaVersion: UInt64 = 7

  func configureRealm() {
    let config = Realm.Configuration(
      schemaVersion: self.schemaVersion,
      migrationBlock: { _, oldSchemaVersion in
        if (oldSchemaVersion < self.schemaVersion) {
          // Nothing to do!
        }
      })

    Realm.Configuration.defaultConfiguration = config
    _ = try! Realm()
  }
}
