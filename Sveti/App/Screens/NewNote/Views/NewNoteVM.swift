import UIKit
import RealmSwift

class NewNoteVM: ViewControllerVM {

  private var note = Note()

  override func handle<T: Event>(_ event: T) {
    super.handle(event)
    guard let event = event as? EditEvent else { return }
    let eventType = NoteEditType(rawValue: event.type)
    self.hasChanges = true
    var needReload = false

      switch eventType {
      case .emotionalStateChange:
        guard let value = event.value as? Double else { return }
        note.mood?.emotionalState = value

      case .physicalStateChange:
        guard let value = event.value as? Double else { return }
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
      case .needUpdate:
        guard let note = event.value as? Note else { return }
        self.note = note
        needReload = true
        informationDelegate?.showUpdatedAlert()
      }

    updateContent(needReload)
  }

  private func updateContent(_ needReaload: Bool = false) {
    tableDataProvider?.updateSections(with: note)
    if needReaload { contentUpdateDelegate?.reloadContent() }
  }

  func saveCurrentNote() {
    NotesRepository().save(note)
    StatDayContentManager.shared.needUpdateViews = true
    StatDaysDataManager().updateStat(with: note)
  }

  func clearInput() {
    subscribers.removeAll()
    observingCellsWithIds.removeAll()
    note = Note()
  }

  func setNote(with id: Int) {
    guard let note = NotesRepository().getNote(with: id),
    let mood = note.mood,
    let splitDate = note.splitDate else { return }

    self.note = Note(value: note)
    self.note.mood = Mood(value: mood)
    self.note.splitDate = SplitDate(value: splitDate)
  }

  func handleTagEditing(with tag: Tag) {
    if note.tags.contains(where: { $0.id == tag.id }) {
      guard let existingTagIndex = note.tags.firstIndex(where: { $0.id == tag.id }) else { return }
      note.tags.remove(at: existingTagIndex)
    } else {
      note.tags.append(tag)
    }
  }

  func isFirstNoteForToday() -> Bool {
    let notes = NotesRepository().getNotes()
    let todayNote = notes.first { note in
      return note.splitDate?.ddMMyyyy == SplitDate(rawDate: Date()).ddMMyyyy
    }
    return todayNote == nil
  }
}
