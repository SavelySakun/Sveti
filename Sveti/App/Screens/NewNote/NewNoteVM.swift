import UIKit
import RealmSwift

class NewNoteVM: ViewControllerVM {

  private var note = Note()
  private let realm = try! Realm()

  override func handle<T: Event>(_ event: T) {
    super.handle(event)
    guard let event = event as? EditEvent else { return }
    let eventType = NoteEditType(rawValue: event.type)
    self.hasChanges = true

    try! realm.write {
      switch eventType {
      case .emotionalStateChange:
        guard let value = event.value as? Float else { return }
        note.mood?.emotionalState = value

      case .physicalStateChange:
        guard let value = event.value as? Float else { return }
        note.mood?.physicalState = value

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
    StatStateManager().updateStat(with: note)
  }


  func clearInput() {
    subscribers.removeAll()
    observingCellsWithIds.removeAll()
    note = Note()
  }

  func setNote(with id: Int) {
    guard let note = NotesRepository().getNote(with: id) else { return }
    self.note = note
  }

  func handleTagEditing(with tag: Tag) {
    if note.tags.contains(where: { $0.id == tag.id }) {
      guard let existingTagIndex = note.tags.firstIndex(where: { $0.id == tag.id }) else { return }
      note.tags.remove(at: existingTagIndex)
    } else {
      note.tags.append(tag)
    }
  }
}
