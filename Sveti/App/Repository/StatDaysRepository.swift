import Foundation
import RealmSwift

class StatDaysRepository {

  let realm = try! Realm()

  func getStatDay(with date: String) -> StatDay? {
    return realm.objects(StatDay.self).filter("date = %@", date).first
  }

  func addDataToExistingStatDay(with statDay: StatDay, note: Note) {
    let object = realm.objects(StatDay.self).filter("date = %@", statDay.date).first

    guard let existingStatDay = object,
          let mood = note.mood else { return }

    try! realm.write {
      existingStatDay.emotionalStates.append(mood.emotionalState)
      existingStatDay.phyzicalStates.append(mood.physicalState)
    }
  }

  func removeDataFromExistingStatDay(with statDay: StatDay, note: Note) {
    let object = realm.objects(StatDay.self).filter("date = %@", statDay.date).first

    guard let existingStatDay = object,
          let mood = note.mood,
          let emotionalStateIndex = existingStatDay.emotionalStates.firstIndex(of: mood.emotionalState),
          let phizicalStateIndex = existingStatDay.emotionalStates.firstIndex(of: mood.physicalState)
          else { return }

    try! realm.write {
      existingStatDay.emotionalStates.remove(at: emotionalStateIndex)
      existingStatDay.phyzicalStates.remove(at: phizicalStateIndex)
    }
    removeIfNoData(statDay: existingStatDay)
  }

  func removeIfNoData(statDay: StatDay) {
    guard statDay.emotionalStates.isEmpty else { return }
    try! realm.write {
      realm.delete(statDay)
    }
  }

  func saveNewStatDay(statDay: StatDay) {
    try! realm.write {
      realm.add(statDay)
    }
  }

}
