import Foundation
import RealmSwift
import CloudKit

class BackupManager {

  private let userDefaults = UserDefaults()
  private let database = CKContainer(identifier: "iCloud.com.sava.sveti").privateCloudDatabase
  private let filemanager = FileManager.default
  private let backupRecordType = "SvetiBackup"
  private var backupExist: Bool = false
  private var backupFileURL: URL?

  func getRealmURL() -> URL? {
    Realm.Configuration.defaultConfiguration.fileURL
  }

  func saveToCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let realmFileURL = getRealmURL() else {
      onCompletion(nil, "Can't find correct path to local data")
      return
    }
    let backupRecord = CKRecord(recordType: backupRecordType)
    backupRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
    database.save(backupRecord) { _, error in
      guard error == nil else {
        let errorDescription = error?.localizedDescription ?? "Unknown saving backup error"
        onCompletion(nil, errorDescription)
        return
      }
      onCompletion(BackupInfo(state: .successBackupedToCloud, lastBackupDate: Date()), nil)
    }
  }

  func updateExistingBackupRecord(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let realmFileURL = getRealmURL(),
    let existingRecord = getExistingBackupRecord() else { return }
    existingRecord["realmfile"] = CKAsset(fileURL: realmFileURL)

    let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [existingRecord], recordIDsToDelete: nil)
    modifyRecordsOperation.savePolicy = .changedKeys
    modifyRecordsOperation.modifyRecordsCompletionBlock = { _, _, error in
      guard error == nil else {
        let errorDescription = error?.localizedDescription ?? "Unknown modification backup error"
        onCompletion(nil, errorDescription)
        return
      }
      onCompletion(BackupInfo(state: .successBackupedToCloud, lastBackupDate: Date()), nil)
    }
    database.add(modifyRecordsOperation)
  }

  private func getExistingBackupRecord() -> CKRecord? {
    guard let backupRecordName = getBackupRecordName() else { return nil }
    return CKRecord(recordType: backupRecordType, recordID: CKRecord.ID(recordName: backupRecordName))
  }

  func deleteFilesInDirectory(url: URL?) {
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

      guard let lastRecord = records?.last,
            let realmAsset = lastRecord.value(forKey: "realmfile") as? CKAsset else {
              self.backupExist = false
              onCompletion(BackupInfo(state: .noBackupFound), nil)
              return
            }

      self.saveBackupCloudKitRecordNameIfNeeded(recordName: lastRecord.recordID.recordName)
      self.backupFileURL = realmAsset.fileURL
      self.backupExist = true
      let backupDate = lastRecord.creationDate ?? lastRecord.modificationDate
      onCompletion(BackupInfo(state: .readyToRestoreBackup, lastBackupDate: backupDate), nil)
    }
  }

  func restoreBackup(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
    guard let backupFileURL = backupFileURL else {
      onCompletion(nil, "Incorrect backup URL")
      return
    }

    guard let realmURL = getRealmURL() else {
      onCompletion(nil, "Can't find correct path to local data")
      return
    }

    self.deleteFilesInDirectory(url: realmURL)

    do {
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

  private func getBackupRecordName() -> String? {
    userDefaults.value(forKey: UDKeys.backupCloudKitRecordName) as? String
  }

  // Saving recordName for updating in the future
  private func saveBackupCloudKitRecordNameIfNeeded(recordName: String) {
    let savedRecordName = userDefaults.value(forKey: UDKeys.backupCloudKitRecordName) as? String
    guard savedRecordName == nil else { return }
    self.userDefaults.set(recordName, forKey: UDKeys.backupCloudKitRecordName)
  }

}
