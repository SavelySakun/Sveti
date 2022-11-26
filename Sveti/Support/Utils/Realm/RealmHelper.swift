import Foundation
import RealmSwift

// Help info about migration: https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html#migrations

class RealmHelper {
    private let userDefaults = UserDefaults()
    var schemaVersion: UInt64 = 9

    func getRealmURL() -> URL? {
        let fileNameForRealmBackup: String? = userDefaults.value(forKey: UDKeys.lastRealmBackupFilename) as? String

        var realmURL: URL? = Realm.Configuration.defaultConfiguration.fileURL
        if let nameForRealmBackup = fileNameForRealmBackup {
            realmURL = Realm.Configuration.defaultConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent(nameForRealmBackup)
        }

        return realmURL
    }

    func configureRealm() {
        let config = Realm.Configuration(
            fileURL: getRealmURL(),
            schemaVersion: schemaVersion,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < self.schemaVersion {
                    // Nothing to do!
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
    }
}
