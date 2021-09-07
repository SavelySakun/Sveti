import Foundation

class StatMoodManager {

  let statDaysRepository = StatDaysRepository()

  func updateStat(with note: Note) {
    guard let date = note.splitDate?.ddMMyyyy else { return }

    if let existingStatDay = statDaysRepository.getStatDay(with: date) {
      statDaysRepository.addDataToExistingStatDay(with: existingStatDay, note: note)
    } else {
      saveStat(with: note)
    }
  }

  // If statDay doesn't exist for specific date
  private func saveStat(with note: Note) {
    let statDayToSave = getNewStatDay(from: note)
    StatDaysRepository().saveNewStatDay(statDay: statDayToSave)
  }

  private func getNewStatDay(from note: Note) -> StatDay {
    let statDay = StatDay()

    guard let mood = note.mood,
          let date = note.splitDate?.ddMMyyyy else { return StatDay() }

    statDay.date = date
    statDay.totalNotes = 1
    statDay.emotionalStates.append(mood.emotionalState)
    statDay.phyzicalStates.append(mood.physicalState)
    return statDay
  }
}

// обновлять запись в конкретный день

// создавать запись со данными по настроению

// возвращать данные готовые для отображения за конкретный диапазон с конкретной группировкой
