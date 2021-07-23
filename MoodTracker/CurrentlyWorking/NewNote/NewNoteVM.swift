import UIKit

class NewNoteVM: ViewControllerVM {

  var note = NoteModel()

  override func handle(_ event: EditEvent) {
    super.handle(event)
    switch event.type {
    case .moodChange:
      print("изменилось настроение")
      note.mood = event.value as! Float
    case .physChange:
      print("изменилось физиология")
      note.phys = event.value as! Float
    case .commentChange:
      print("изменился коммент")
      note.comment = event.value as! String
    }
  }

  func saveCurrentNote() {
    NotesRepository.shared.notes.append(note)
  }

}

