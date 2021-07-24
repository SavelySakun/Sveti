import UIKit

class NewNoteVM: ViewControllerVM {

  var note = Note()

  override func handle(_ event: EditEvent) {
    super.handle(event)
    switch event.type {
    case .moodChange:
      note.mood = event.value as! Float
    case .physChange:
      note.phys = event.value as! Float
    case .commentChange:
      note.comment = event.value as! String
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

