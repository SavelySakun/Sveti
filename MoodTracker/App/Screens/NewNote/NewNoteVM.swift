import UIKit

class NewNoteVM: ViewControllerVM {

  private var note = Note()

  override func handle(_ event: EditEvent) {
    super.handle(event)
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

  func saveCurrentNote() {
    NotesRepository().save(note)
  }
  
  func clearInput() {
    subscribers.removeAll()
    note = Note()
  }

}

