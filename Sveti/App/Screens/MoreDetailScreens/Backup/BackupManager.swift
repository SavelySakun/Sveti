import Foundation
import RealmSwift
import CloudKit

class BackupManager {

  private let userDefaults = UserDefaults()
  private let database = CKContainer(identifier: "iCloud.com.sava.sveti").privateCloudDatabase
  private let filemanager = FileManager.default
  private let backupRecordType = "SvetiBackup"

  func getRealmURL() -> URL? {
    RealmHelper().getRealmURL()
  }

  func isUserICloudAvailable() -> Bool {
    FileManager.default.ubiquityIdentityToken != nil
  }

  func saveToCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let realmFileURL = getRealmURL() else {
      onCompletion(nil, "Can't find correct path to local data")
      return
    }
    let backupRecord = CKRecord(recordType: backupRecordType)
    backupRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
    database.save(backupRecord) { record, error in
      guard error == nil, let record = record else {
        let errorDescription = error?.localizedDescription ?? "Unknown saving backup error"
        onCompletion(nil, errorDescription)
        return
      }
      self.updateBackupLocalInfo(with: record)
      onCompletion(BackupInfo(state: .successBackupedToCloud, lastBackupDate: Date()), nil)
    }
  }

  func updateExistingBackupRecord(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let realmFileURL = getRealmURL() else {
      onCompletion(nil, "Didn't find local files to update backup")
      return
    }

    getExistingBackupRecord() { record in
      guard let existingRecord = record else {
        onCompletion(nil, "The data in the cloud no longer exists. Please refresh")
        return
      }

      existingRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
      let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [existingRecord], recordIDsToDelete: nil)
      modifyRecordsOperation.savePolicy = .changedKeys

      modifyRecordsOperation.modifyRecordsCompletionBlock = { records, _, error in
        guard error == nil, let record = records?.last else {
          let errorDescription = error?.localizedDescription ?? "Unknown modification backup error"
          onCompletion(nil, errorDescription)
          return
        }
        self.updateBackupLocalInfo(with: record)
        onCompletion(BackupInfo(state: .successBackupedToCloud), nil)
      }

      self.database.add(modifyRecordsOperation)
    }
  }

  private func getExistingBackupRecord(onCompletion: @escaping((CKRecord?) -> Void)) {
    guard let backupRecordName = getBackupRecordName() else {
      onCompletion(nil)
      return
    }
    let recordID = CKRecord.ID(recordName: backupRecordName)
    let operation = CKFetchRecordsOperation(recordIDs: [recordID])
    operation.fetchRecordsCompletionBlock = { records, error in
      guard error == nil, let records = records else {
        onCompletion(nil)
        return
      }
      onCompletion(records[recordID])
    }
    database.add(operation)
  }

  func deleteFilesInLocalDirectory(url: URL?) {
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

  // Call this first to know is there any backup
  func loadBackupFromCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    let query = CKQuery(recordType: "SvetiBackup", predicate: NSPredicate(value: true))

    database.perform(query, inZoneWith: nil) { records, error in
      guard error == nil else {
        let error = error?.localizedDescription ?? BackupError.failedToLoadBackup.rawValue
        onCompletion(nil, error)
        return
      }

      guard let lastRecord = records?.last else {
        onCompletion(BackupInfo(state: .noBackupFound), nil)
        return
      }

      self.updateBackupLocalInfo(with: lastRecord)
      let date = lastRecord.modificationDate ?? lastRecord.creationDate
      let backupInfo = BackupInfo(state: .readyToRestoreBackup, lastBackupDate: date)
      onCompletion(backupInfo, nil)
    }
  }

  private func updateBackupLocalInfo(with record: CKRecord) {
    self.userDefaults.set(record.recordID.recordName, forKey: UDKeys.backupCloudKitRecordName)
  }

  func restoreBackup(onCompletion: @escaping (BackupInfo?, String?) -> Void) {

    getExistingBackupRecord { existingBackupRecord in
      guard let record = existingBackupRecord else {
        onCompletion(nil, "Can't find correct backup record in cloud. Please refresh")
        return
      }

      guard let realmBackupAsset = record.value(forKey: "realmfile") as? CKAsset,
        let backupFileURL = realmBackupAsset.fileURL else {
        onCompletion(nil, "Can't find backup file in cloud. Please refresh")
        return
      }

      guard let realmURL = self.getRealmURL() else {
        onCompletion(nil, "Can't find correct path to local data")
        return
      }

      guard FileManager.default.fileExists(atPath: backupFileURL.path) else {
        onCompletion(nil, "There are no correct backup files in the cloud. Please refresh")
        return
      }

      do {
        let backupRealmFileSchemaVersion = try schemaVersionAtURL(backupFileURL, encryptionKey: nil)
        guard backupRealmFileSchemaVersion <= RealmHelper().schemaVersion else {
          onCompletion(nil, "Backup file version is higher than the version of the files in the application. Please update the app")
          return
        }

        self.deleteFilesInLocalDirectory(url: realmURL)

        let fileNameForRealmBackup = "\(UUID().uuidString.prefix(4))_sveti_backup.realm"
        self.userDefaults.set(fileNameForRealmBackup, forKey: UDKeys.lastRealmBackupFilename)
        self.userDefaults.set(Date(), forKey: UDKeys.lastRealmBackupDate)

        let newRealmFileURL = realmURL.deletingLastPathComponent().appendingPathComponent(fileNameForRealmBackup)
        try FileManager.default.copyItem(at: backupFileURL, to: newRealmFileURL)

        let config = Realm.Configuration(fileURL: newRealmFileURL, schemaVersion: RealmHelper().schemaVersion)
        Realm.Configuration.defaultConfiguration = config

        onCompletion(BackupInfo(state: .successRestoreData), nil)
      } catch let error as NSError {
        onCompletion(nil, error.localizedDescription)
      }
    }
  }

  private func getBackupRecordName() -> String? {
    userDefaults.value(forKey: UDKeys.backupCloudKitRecordName) as? String
  }

  func deleteBackupFromCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let recordName = userDefaults.value(forKey: UDKeys.backupCloudKitRecordName) as? String else { return }
    database.delete(withRecordID: CKRecord.ID(recordName: recordName)) { _, error in
      guard error == nil else {
        let error = error?.localizedDescription ?? "Unknown error during record deletion"
        onCompletion(nil, error)
        return
      }
      self.userDefaults.set(nil, forKey: UDKeys.backupCloudKitRecordName)
      onCompletion(BackupInfo(state: .backupDeleted), nil)
    }
  }
}
