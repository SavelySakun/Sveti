import Foundation

class StatDaysManager {

  private let statDaysRepository = StatDaysRepository()

  /// Use for getting statDay using note information.
  func findStatDay(from note: Note) -> StatDay? {
    guard let date = note.splitDate else { return nil }
    return statDaysRepository.getStatDay(with: date)
  }

  func updateStat(with note: Note) {
    if let existingStatDay = findStatDay(from: note) {
      statDaysRepository.addDataToExistingStatDay(with: existingStatDay, note: note)
    } else {
      saveStat(with: note)
    }
  }

  func removeStat(with note: Note) {
    if let existingStatDay = findStatDay(from: note) {
      statDaysRepository.removeDataFromExistingStatDay(with: existingStatDay, note: note)
    }
  }

  /// If statDay doesn't exist for specific date
  func saveStat(with note: Note) {
    let statDayToSave = getNewStatDay(from: note)
    StatDaysRepository().saveNewStatDay(statDay: statDayToSave)
  }

  func getNewStatDay(from note: Note) -> StatDay {
    let statDay = StatDay()

    guard let mood = note.mood,
          let date = note.splitDate else { return StatDay() }

    statDay.splitDate = date
    statDay.totalNotes = 1
    statDay.emotionalStates.append(mood.emotionalState)
    statDay.phyzicalStates.append(mood.physicalState)
    return statDay
  }

}

// обновлять запись в конкретный день

// создавать запись со данными по настроению

// возвращать данные готовые для отображения за конкретный диапазон с конкретной группировкой
