import UIKit
import RealmSwift

class NewNoteVM: ViewControllerVM {

  private var note = Note()
  private let realm = try! Realm()

  override func handle(_ event: EditEvent) {
    super.handle(event)

    try! realm.write {
      switch event.type {
      case .emotionalStateChange:
        guard let value = event.value as? Float else { return }
        note.mood?.emotionalState = value

      case .physicalStateChange:
        guard let value = event.value as? Float else { return }
        note.mood?.physicalState = value

      case .willToLiveChange:
        guard let value = event.value as? Float else { return }
        note.mood?.willToLive = value

      case .commentChange:
        guard let value = event.value as? String else { return }
        note.comment = value

      case .dateChange:
        guard let value = event.value as? Date else { return }
        let date = value
        note.splitDate = SplitDate(rawDate: date)
      }
    }
  }

  func saveCurrentNote() {
    NotesRepository().save(note)
  }
  
  func clearInput() {
    subscribers.removeAll()
    note = Note()
  }

  func setNote(with id: Int) {
    guard let note = NotesRepository().getNote(with: id) else { return }
    self.note = note
  }

}

