import UIKit

class StatsTableView: TableView {
    override func configureTable() {
        let tableHeaderView = StatsTableHeaderView(frame: .init(x: 0, y: 0, width: frame.width, height: 100))

        let subscriber = tableHeaderView.publisher
            .debounce(for: .seconds(eventDebounceValue), scheduler: RunLoop.main)
            .sink { event in
                self.viewModel.handle(event)
            }

        viewModel.addSubscriber(newSub: subscriber, with: tableHeaderView.identifier)
        self.tableHeaderView = tableHeaderView
    }
}
