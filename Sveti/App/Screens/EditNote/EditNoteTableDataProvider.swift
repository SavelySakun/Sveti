import Foundation

class EditNoteTableDataProvider: TableDataProvider {
    override func configureSections(with data: Any? = nil) -> [TableSection] {
        var tableSections = [
            TableSection(title: "Date".localized, cellsData: [
                CellData(type: DatePickerCell.self, viewModel: CellVM(cellValue: data)),
            ]),

            TableSection(title: "Tags".localized, cellsData: [
                CellData(type: TagCell.self, viewModel: CellVM(title: nil, cellValue: data)),
            ]),

            TableSection(title: "Mood".localized, cellsData: [
                CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Physical".localized, cellValue: data)),
                CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Emotional".localized, cellValue: data)),
            ]),

            TableSection(title: "Comment".localized, cellsData: [
                CellData(type: CommentCell.self, viewModel: CellVM(cellValue: data)),
            ]),
        ]

        if !checkIsAnyTagGroupExist() {
            tableSections[1].cellsData[0] = CellData(type: NonExistingTagsCell.self, viewModel: CellVM(cellValue: NonTagGroupsItem()))
        }

        if let note = data as? Note {
            let nonExistingTags = findAlreadyNotExistingTags(in: note)
            guard !nonExistingTags.isEmpty,
                  let deleteNonExistingTagsCellValue = getDeleteNonExistingTagsCellData(from: nonExistingTags, note: note) else { return tableSections }

            tableSections.append(TableSection(title: "Optional", cellsData: [deleteNonExistingTagsCellValue]))
        }

        return tableSections
    }

    private func findAlreadyNotExistingTags(in note: Note) -> [Tag] {
        var nonExistingTags = [Tag]()

        note.tags.forEach { tag in
            if TagsRepository().findTag(withId: tag.id) == nil {
                nonExistingTags.append(tag)
            }
        }

        return nonExistingTags
    }

    private func getDeleteNonExistingTagsCellData(from tags: [Tag], note: Note) -> CellData? {
        let item = NonExistingTagsItem()
        for (index, tag) in tags.enumerated() {
            item.subtitle?.append(index == 0 ? " \"\(tag.name)\"" : ", \"\(tag.name)\"")
        }

        let editingNote = Note(value: note)
        item.onTapAction = { publisher in
            tags.forEach { tag in
                guard let tagIndex = editingNote.tags.firstIndex(where: { $0.id == tag.id }) else { return }
                editingNote.tags.remove(at: tagIndex)
            }

            let event = EditEvent(type: .needUpdate, value: editingNote)
            publisher?.send(event)
        }

        return CellData(type: TouchableSimpleCell.self, viewModel: CellVM(cellValue: item))
    }

    private func checkIsAnyTagGroupExist() -> Bool {
        !TagsRepository().groups.isEmpty
    }
}
