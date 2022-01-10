import Foundation
import RealmSwift

// Help info about migration: https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html#migrations

class RealmHelper {

  private let userDefaults = UserDefaults()

  var schemaVersion: UInt64 {
    (userDefaults.value(forKey: UDKeys.realmSchemeVersion) as? UInt64) ?? 7
  }

 

  init() {
    setDefaults()
  }

  private func setDefaults() {
    userDefaults.register(
      defaults: [UDKeys.realmSchemeVersion: 7]
    )
  }

  func incrementSchemaVersion() {
    userDefaults.set(schemaVersion + 1, forKey: UDKeys.realmSchemeVersion)
  }

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
