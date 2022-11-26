import CloudKit
import Foundation
import RealmSwift

class BackupManager {
    private let userDefaults = UserDefaults()
    private let database = CKContainer(identifier: "iCloud.com.sava.sveti").privateCloudDatabase
    private let filemanager = FileManager.default
    private let backupRecordType = "SvetiBackup"

    private func getRealmURL() -> URL? {
        RealmHelper().getRealmURL()
    }

    // For backup feature user has to be authorized in iCloud
    func isUserICloudAvailable() -> Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }

    func createBackupInCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
        guard let realmFileURL = getRealmURL() else {
            onCompletion(nil, "Can't find correct path to local data".localized)
            return
        }
        let backupRecord = CKRecord(recordType: backupRecordType)
        backupRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
        database.save(backupRecord) { record, error in
            guard error == nil, let record = record else {
                let errorDescription = error?.localizedDescription ?? "Unknown saving backup error".localized
                onCompletion(nil, errorDescription)
                return
            }
            self.updateBackupLocalInfo(with: record)
            onCompletion(BackupInfo(state: .successBackupedToCloud, lastBackupDate: Date()), nil)
        }
    }

    func updateExistingBackupRecord(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
        guard let realmFileURL = getRealmURL() else {
            onCompletion(nil, "Didn't find local files to update backup".localized)
            return
        }

        getExistingBackupRecord { record in
            guard let existingRecord = record else {
                onCompletion(nil, "The data in the cloud no longer exists. Please refresh".localized)
                return
            }

            existingRecord["realmfile"] = CKAsset(fileURL: realmFileURL)
            let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: [existingRecord],
                                                                  recordIDsToDelete: nil)
            modifyRecordsOperation.savePolicy = .changedKeys

            modifyRecordsOperation.modifyRecordsCompletionBlock = { records, _, error in
                guard error == nil, let record = records?.last else {
                    let errorDescription = error?.localizedDescription ?? "Unknown backup modification error".localized
                    onCompletion(nil, errorDescription)
                    return
                }

                self.updateBackupLocalInfo(with: record)
                onCompletion(BackupInfo(state: .successBackupedToCloud, lastBackupDate: Date()), nil)
            }

            self.database.add(modifyRecordsOperation)
        }
    }

    private func getExistingBackupRecord(onCompletion: @escaping ((CKRecord?) -> Void)) {
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

    // We need to store recordName of existing record in CloudKit to use it for updating & deleting backup file in cloud
    private func updateBackupLocalInfo(with record: CKRecord) {
        userDefaults.set(record.recordID.recordName, forKey: UDKeys.backupCloudKitRecordName)
    }

    private func getBackupRecordName() -> String? {
        userDefaults.value(forKey: UDKeys.backupCloudKitRecordName) as? String
    }

    func restoreBackup(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
        getExistingBackupRecord { existingBackupRecord in
            guard let record = existingBackupRecord else {
                onCompletion(nil, "Can't find correct backup record in the cloud. Please refresh".localized)
                return
            }

            guard let realmBackupAsset = record.value(forKey: "realmfile") as? CKAsset,
                  let backupFileURL = realmBackupAsset.fileURL
            else {
                onCompletion(nil, "Can't find backup file in the cloud. Please refresh".localized)
                return
            }

            guard FileManager.default.fileExists(atPath: backupFileURL.path) else {
                onCompletion(nil, "There are no correct backup files in the cloud. Please refresh".localized)
                return
            }

            LocalFilesManager().restoreBackup(from: backupFileURL) { isRestored, error in
                guard error == nil, isRestored == true else {
                    onCompletion(nil, error ?? "Unknown data recovery error".localized)
                    return
                }
                onCompletion(BackupInfo(state: .successDataRestore), nil)
            }
        }
    }

    func deleteBackupFromCloudKit(onCompletion: @escaping (BackupInfo?, String?) -> Void) {
        guard let recordName = getBackupRecordName() else {
            onCompletion(nil, "Cloud backup already doesn't exist. Please refresh".localized)
            return
        }
        database.delete(withRecordID: CKRecord.ID(recordName: recordName)) { _, error in
            guard error == nil else {
                let error = error?.localizedDescription ?? "Unknown error during record deletion".localized
                onCompletion(nil, error)
                return
            }
            self.userDefaults.set(nil, forKey: UDKeys.backupCloudKitRecordName)
            onCompletion(BackupInfo(state: .backupDeleted), nil)
        }
    }
}
