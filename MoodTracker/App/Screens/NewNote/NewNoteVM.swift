import UIKit
import RealmSwift

class NewNoteVM: ViewControllerVM {

  private var note = Note()
  private let realm = try! Realm()

  override func handle<T: Event>(_ event: T) {
    super.handle(event)
    guard let event = event as? EditEvent else { return }
    let eventType = NoteEditType(rawValue: event.type)

    try! realm.write {
      switch eventType {
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

      case .tagChange:
        guard let tag = event.value as? Tag else { return }
        handleTagEditing(with: tag)
      case .none:
        return
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

  func handleTagEditing(with tag: Tag) {
    if note.tags.contains(tag) {
      guard let existingTagId = note.tags.firstIndex(of: tag) else { return }
      note.tags.remove(at: existingTagId)
    } else {
      note.tags.append(tag)
    }
  }
}
