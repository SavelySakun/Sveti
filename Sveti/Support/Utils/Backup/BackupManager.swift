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

  func saveToCloudKit() {
    guard let realmFileURL = getRealmURL() else { return }
    let backupRecord = CKRecord(recordType: backupRecordType)
    backupRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
    database.save(backupRecord) { record, error in
      if error == nil {
        print("success save record")
      }
    }
  }

  func updateExistingBackupRecord() {
    guard let realmFileURL = getRealmURL(),
    let existingRecord = getExistingBackupRecord() else { return }
    existingRecord["realmfile"] = CKAsset(fileURL: realmFileURL)

    let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [existingRecord], recordIDsToDelete: nil)
    modifyRecordsOperation.savePolicy = .changedKeys
    modifyRecordsOperation.modifyRecordsCompletionBlock = { _, _, error in

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

  // Call this first to know is there any backup exist
  func loadBackupFromCloudKit() {
    let query = CKQuery(recordType: "SvetiBackup", predicate: NSPredicate(value: true))
    database.perform(query, inZoneWith: nil) { records, error in

      guard let lastRecord = records?.last,
            let realmAsset = lastRecord.value(forKey: "realmfile") as? CKAsset else {
              self.backupExist = false
              return
            }

      self.saveBackupCloudKitRecordNameIfNeeded(recordName: lastRecord.recordID.recordName)
      self.backupFileURL = realmAsset.fileURL
      self.backupExist = true
    }
  }

  func restoreBackup() {
    guard let backupFileURL = backupFileURL else { return }
    updateRealmWithBackup(backupFileURL: backupFileURL)
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

  private func updateRealmWithBackup(backupFileURL: URL) {
    guard let realmURL = getRealmURL() else { return }
    self.deleteFilesInDirectory(url: realmURL)

    do {
      let fileNameForRealmBackup = "\(UUID().uuidString.prefix(4))_sveti_backup.realm"
      self.userDefaults.set(fileNameForRealmBackup, forKey: UDKeys.lastRealmBackupFilename)
      self.userDefaults.set(Date(), forKey: UDKeys.lastRealmBackupDate)

      let newRealmFileURL = realmURL.deletingLastPathComponent().appendingPathComponent(fileNameForRealmBackup)
      try FileManager.default.copyItem(at: backupFileURL, to: newRealmFileURL)

      let config = Realm.Configuration(fileURL: newRealmFileURL, schemaVersion: RealmHelper().schemaVersion)
      Realm.Configuration.defaultConfiguration = config

      print("Successfully copyied Realm from iCloud!")
    } catch let error as NSError {
      print("Failed copying Realm from iCloud: \(error)")
    }
  }

}
