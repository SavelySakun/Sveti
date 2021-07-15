import UIKit

class NewNoteVM: ViewControllerVM {

  override func handle(_ event: EditEvent) {
    super.handle(event)

    switch event.type {
    case .moodChange:
      print("изменилось настроение")
    case .physChange:
      print("изменилось физиология")
    case .commentChange:
      print("изменился коммент")
    }

  }

}

