import Foundation

class StatDaysInstruments {
    private let math = SvetiMath()
    private let settings: StatSettings

    init(with settings: StatSettings? = nil) {
        self.settings = settings ?? StatSettingsRepository().settings
    }

    func getAverageMoods(from statDay: StatDay) -> [Double] {
        var low = 0
        let high = (statDay.emotionalStates.count - 1)

        var averageMoods = [Double]()

        while low <= high {
            let emotionalState = statDay.emotionalStates[low]
            let phyzicalState = statDay.phyzicalStates[low]
            let averageMood = math.average([emotionalState, phyzicalState])
            averageMoods.append(averageMood)
            low += 1
        }

        return averageMoods
    }

    func filterByTimeRange(data: [StatDay]) -> [StatDay] {
        let timeRangeFilteredData = data.filter { statDay in
            guard let splitDate = statDay.splitDate else { return false }
            let minimumDateInterval = settings.minimumDate.timeIntervalSince1970
            let maximumDateInterval = settings.maximumDate.timeIntervalSince1970
            let statDayInterval = splitDate.rawDate.timeIntervalSince1970
            return statDayInterval >= minimumDateInterval && statDayInterval <= maximumDateInterval
        }
        return timeRangeFilteredData
    }

    func orderByDate(data: [DrawableStat]) -> [DrawableStat] {
        let sortedByTimeData = data.sorted {
            let date0 = $0.splitDate
            let date1 = $1.splitDate
            return date0.rawDate.timeIntervalSince1970 < date1.rawDate.timeIntervalSince1970
        }
        return sortedByTimeData
    }

    func group(data: [StatDay]) -> [Date: [StatDay]] {
        switch settings.groupingType {
        case .day:
            return data.groupedBy(dateComponents: [.year, .month, .day])
        case .week:
            return data.groupedBy(dateComponents: [.yearForWeekOfYear, .weekOfMonth, .weekOfYear])
        case .month:
            return data.groupedBy(dateComponents: [.year, .month])
        case .year:
            return data.groupedBy(dateComponents: [.year])
        }
    }
}
