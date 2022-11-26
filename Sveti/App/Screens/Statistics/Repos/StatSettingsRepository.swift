import Foundation
import RealmSwift

class StatSettingsRepository: IRepository {
    typealias T = StatSettings
    var realm: Realm = try! Realm()
    private let userDefaults = UserDefaults()

    var settings: T {
        realm.objects(T.self).last ?? StatSettings()
    }

    init() {
        setupDefaults()
    }

    func setupDefaults() {
        userDefaults.register(
            defaults: [UDKeys.isDefaultStatDaysSettingsSaved: false]
        )
    }

    func get() -> StatSettings {
        return settings
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

    func updateMinimumDate(_ date: Date) {
        try! realm.write {
            settings.minimumDate = date
        }
    }

    func updateMaximumDate(_ date: Date) {
        try! realm.write {
            settings.maximumDate = date
        }
    }

    func updateGrouping(_ groupingType: GroupingType) {
        try! realm.write {
            settings.groupingType = groupingType
        }
    }

    func updateStatType(_ statType: StatType) {
        try! realm.write {
            settings.statType = statType
        }
    }
}
