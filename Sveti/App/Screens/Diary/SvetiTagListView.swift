import UIKit
import TagListView

class SvetiTagListView: TagListView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    isUserInteractionEnabled = false
    textFont = UIFont.systemFont(ofSize: 14)
    cornerRadius = 6
    paddingY = 5
    paddingX = 8
    marginY = 5
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setTags(from note: Note) {
    removeAllTags()
    tagBackgroundColor = ColorHelper().getColor(value: Int(note.mood?.average ?? 6.0), palette: .tag)

    note.tags.forEach { tag in
      addTag(tag.name)
    }
  }
}
