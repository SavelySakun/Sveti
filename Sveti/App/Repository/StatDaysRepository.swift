import Foundation
import RealmSwift

class StatDaysRepository {

  let realm = try! Realm()

  func getAll() -> [StatDay]? {
    return realm.objects(StatDay.self).toArray()
  }

  func getStatDay(with date: SplitDate?) -> StatDay? {
    let allObjects = realm.objects(StatDay.self)
    let specificStatDay = allObjects.first(where: { $0.splitDate?.ddMMyyyy == date?.ddMMyyyy })
    return specificStatDay
  }

  func addDataToExistingStatDay(with statDay: StatDay, note: Note) {
    let specificStatDay = getStatDay(with: statDay.splitDate)

    guard let existingStatDay = specificStatDay,
          let mood = note.mood else { return }

    try! realm.write {
      existingStatDay.emotionalStates.append(mood.emotionalState)
      existingStatDay.phyzicalStates.append(mood.physicalState)
    }
  }

  func removeDataFromExistingStatDay(with statDay: StatDay, note: Note) {
    let specificStatDay = getStatDay(with: statDay.splitDate)

    guard let existingStatDay = specificStatDay,
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

  func removeAll() {
    let allStatDaysObjects = realm.objects(StatDay.self)
    try! realm.write {
      realm.delete(allStatDaysObjects)
    }
  }

  func isHaveSavedObjects() -> Bool {
    return !realm.objects(StatDay.self).isEmpty
  }

  func getSavedObjectsCount() -> Int {
    return realm.objects(StatDay.self).count
  }
}
