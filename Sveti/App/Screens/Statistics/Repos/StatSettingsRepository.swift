import Foundation
import RealmSwift

class StatSettingsRepository: IRepository {
  typealias T = StatSettings
  var realm: Realm = try! Realm()
  private let userDefaults = UserDefaults()

  init() {
    setupDefaults()
  }

  func setupDefaults() {
    userDefaults.register(
      defaults: [UDKeys.isDefaultStatDaysSettingsSaved: false]
    )
  }

  func get() -> StatSettings {
    let settings = realm.objects(StatSettings.self).toArray().first
    return settings ?? StatSettings()
  }

  func save(object: Object) {
    try! realm.write {
      realm.add(object)
    }
  }

  func saveDefaultSettings() {
    let isSaved = userDefaults.bool(forKey: UDKeys.isDefaultStatDaysSettingsSaved)
    guard !isSaved else { return }
    try! realm.write {
      realm.add(StatSettings())
    }
    userDefaults.set(true, forKey: UDKeys.isDefaultStatDaysSettingsSaved)
  }
}
