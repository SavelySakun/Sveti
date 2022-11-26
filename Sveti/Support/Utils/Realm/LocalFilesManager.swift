import Foundation
import RealmSwift

typealias DataChangeResult = (Bool, String?)

class LocalFilesManager {
    private let filemanager = FileManager.default
    private let userDefaults = UserDefaults()

    func restoreBackup(from backupFileURL: URL, onCompletion: @escaping ((DataChangeResult) -> Void)) {
        // Get URL of local Realm file
        guard let realmURL = RealmHelper().getRealmURL() else {
            onCompletion((false, "Can't find correct path to local data".localized))
            return
        }

        do {
            // Check correct scheme version of Realm to avoid crash when local verson lower then in backup
            let backupRealmFileSchemaVersion = try schemaVersionAtURL(backupFileURL, encryptionKey: nil)
            guard backupRealmFileSchemaVersion <= RealmHelper().schemaVersion else {
                onCompletion((false, "Backup file version is higher than the version of the files in the application. Please update the app".localized))
                return
            }

            deleteFilesInLocalDirectory(url: realmURL)

            // Generate name & file URL for new Realm file with backuped data
            let fileNameForRealmBackup = "\(UUID().uuidString.prefix(4))_sveti_backup.realm"
            userDefaults.set(fileNameForRealmBackup, forKey: UDKeys.lastRealmBackupFilename)
            let newRealmFileURL = realmURL.deletingLastPathComponent().appendingPathComponent(fileNameForRealmBackup)

            // Copy from backup URL to local new Realm file
            try FileManager.default.copyItem(at: backupFileURL, to: newRealmFileURL)

            // Change default configuration to update local files without app reloading
            let config = Realm.Configuration(fileURL: newRealmFileURL, schemaVersion: RealmHelper().schemaVersion)
            Realm.Configuration.defaultConfiguration = config

            onCompletion((true, nil))
        } catch let error as NSError {
            onCompletion((false, error.description))
        }
    }

    private func deleteFilesInLocalDirectory(url: URL?) {
        guard let url = url else { return }
        do {
            let folderURL = url.deletingLastPathComponent()
            let enumerator = filemanager.enumerator(atPath: folderURL.path)
            while let file = enumerator?.nextObject() as? String {
                do {
                    try filemanager.removeItem(at: folderURL.appendingPathComponent(file))
                    print("Old file deleted")
                } catch let error as NSError {
                    print("Failed deleting files : \(error)")
                }
            }
        }
    }
}
