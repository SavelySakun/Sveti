import Foundation

class StatSettingsManager: IStatSettingsManager {
  private let repository = StatSettingsRepository()
  static let shared = StatSettingsManager()

  var settings: StatSettings

  init() {
    settings = repository.get()
  }
}
