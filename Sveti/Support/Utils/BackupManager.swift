import Foundation
import RealmSwift

struct DocumentsDirectory {
  let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.Sveti")?.appendingPathComponent("Documents")
}

class BackupManager {

  let directories = DocumentsDirectory()
  private let fileManager = FileManager.default

  func getRealmURL() -> URL? {
    Realm.Configuration.defaultConfiguration.fileURL
  }

  func makeRealmCopyToCloud() {
    guard let iCloudURL = directories.iCloudDocumentsURL else { return }
    deleteFilesInDirectory(url: iCloudURL)
    do {
      try Realm().writeCopy(toFile: iCloudURL)
      print("File saved")
    } catch let error as NSError {
      print("Failed saving files: \(error)")
    }
  }

  func deleteFilesInDirectory(url: URL?) {
    guard let url = url else { return }
      do {
        let folderURL = url.deletingLastPathComponent()
        let enumerator = fileManager.enumerator(atPath: folderURL.path)
        while let file = enumerator?.nextObject() as? String {
          do {
            try fileManager.removeItem(at: folderURL.appendingPathComponent(file))
            print("Files deleted")
          } catch let error as NSError {
            print("Failed deleting files : \(error)")
          }
        }
      }
  }

  func copyRealmFromCloud() {
    guard let iCloudURL = directories.iCloudDocumentsURL,
          let realmURL = Realm.Configuration.defaultConfiguration.fileURL else { return }

    deleteFilesInDirectory(url: realmURL)

    do {
      try fileManager.copyItem(at: iCloudURL, to: realmURL)

//      let realmHelper = RealmHelper()
//      realmHelper.incrementSchemaVersion()
//      realmHelper.configureRealm()


      print("Successfully copyied Realm from iCloud!")
    } catch let error as NSError {
      print("Failed copying Realm from iCloud: \(error)")
    }

  }

  func restoreRealmFromCloud() {
    do {
      guard let realmDefaultURL = Realm.Configuration.defaultConfiguration.fileURL else {
        print("No realmDefaultURL")
        return
      }

      let config = Realm.Configuration(fileURL: realmDefaultURL)
      Realm.Configuration.defaultConfiguration = config

      let realm = try Realm()
      realm.refresh()

      print("Successfully restored Realm!")
    } catch let error as NSError {
      print("Failed restoring Realm: \(error)")
    }
  }

}
