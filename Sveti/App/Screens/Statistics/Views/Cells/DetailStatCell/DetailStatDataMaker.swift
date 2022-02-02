import Foundation
import SigmaSwiftStatistics

class DetailStatDataMaker {
  private let math = SvetiMath()

  private func getDefaultDetailStatItems() -> [DetailStatItem] {
    [DetailStatItem(type: .max, iconName: "detailStatMax", title: "Max:".localized, value: "-"),
      DetailStatItem(type: .min, iconName: "detailStatMin", title: "Min:".localized, value: "-"),
      DetailStatItem(type: .average, iconName: "detailStatAverage", title: "Avg:".localized, value: "-"),
      DetailStatItem(type: .totalNotes, iconName: "detailStatTotalNotes", title: "Notes:".localized, value: "-"),
      DetailStatItem(type: .stability, iconName: "detailStatStability", title: "Stability:".localized, value: "-")]
  }

  func getPeriodItems() -> [DetailStatItem] {
    guard let drawedStats = StatDayContentManager.shared.currentlyDrawedStat, !drawedStats.isEmpty else { return [DetailStatItem]() }

    let statType = StatSettingsRepository().settings.statType
    let items = getDefaultDetailStatItems()

    items.forEach { item in
      var result: Double? = 0.0

      switch item.type {
      case .date, .change: return

      case .max:
        let maxs = drawedStats.compactMap { $0.maxMood.get(statType) }
        result = Sigma.max(maxs)

      case .min:
        let mins = drawedStats.compactMap { $0.minMood.get(statType) }
        result = Sigma.min(mins)

      case .average:
        let averages = drawedStats.compactMap { $0.averageMood.get(statType) }
        result = Sigma.average(averages)

      case .stability:
        result = calculateStabilityForPeriod(statType: statType)

      case .totalNotes:
        let notes = drawedStats.compactMap { $0.totalNotes }
        result = Sigma.sum(notes)
      }

      item.value = getValue(from: result, detailStatType: item.type)
    }

    return items
  }

  private func calculateStabilityForPeriod(statType: StatType) -> Double? {
    let instruments = StatDaysInstruments()
    guard let allStatDays = StatDaysRepository().getAll() else { return nil }
    let filteredStatDays = instruments.filterByTimeRange(data: allStatDays)

    let states: [Double]

    switch statType {
    case .emotional:
      states = filteredStatDays.flatMap { $0.phyzicalStates }
    case .physical:
      states = filteredStatDays.flatMap { $0.emotionalStates }
    case .all:
      states = filteredStatDays.flatMap { instruments.getAverageMoods(from: $0) }
    }

    guard !states.isEmpty else { return nil }
    return math.calculateStability(from: states)
  }

  func getItemsForSelectedBar(at index: Int) -> [DetailStatItem] {
    guard let drawedStats = StatDayContentManager.shared.currentlyDrawedStat, !drawedStats.isEmpty else { return [DetailStatItem]() }

    let settings = StatSettingsRepository().settings
    let statType = settings.statType
    let groupungType = settings.groupingType

    var items = getDefaultDetailStatItems()
    let dateItem = DetailStatItem(type: .date, iconName: "detailStatCalendar", title: "Date:".localized, value: "-")
    items.insert(dateItem, at: 0)

    let previousStat = drawedStats[safe: index - 1]
    if previousStat != nil {
      let changeItem = DetailStatItem(type: .change, iconName: "detailStatChange", title: "Change:".localized, value: "-")
      items.insert(changeItem, at: 3)
    }

    items.forEach { item in
      var result: Any? = 0.0
      
      switch item.type {
      case .date:
        result = getDate(from: drawedStats[index].splitDate, with: groupungType)
      case .max:
        result = drawedStats[index].maxMood.get(statType)
      case .min:
        result = drawedStats[index].minMood.get(statType)
      case .average:
        result = drawedStats[index].averageMood.get(statType)
      case .stability:
        result = drawedStats[index].stability?.get(statType)
      case .totalNotes:
        result = drawedStats[index].totalNotes
      case .change:
        guard let previousStat = previousStat else { return }
        let previousValue = previousStat.averageMood.get(statType)
        let value = drawedStats[index].averageMood.get(statType)
        let percentageChange = math.calculatePercentageChange(from: previousValue, value2: value)
        result = percentageChange
      }

      item.value = getValue(from: result, detailStatType: item.type)
    }
    return items
  }

  private func getDate(from splitDate: SplitDate, with groupingType: GroupingType) -> String {
    switch groupingType {
    case .day:
      return splitDate.dMM
    case .week:
      return splitDate.ddMMyy
    case .month:
      return splitDate.MMYY
    case .year:
      return splitDate.yyyy
    }
  }

  private func getValue(from data: Any?, detailStatType: DetailStatType) -> String {
    if let data = data as? Double {
      if detailStatType == .stability {
        return "\(SvetiMath().getString(from: data))%"
      } else if detailStatType == .change {
        let value = "\(SvetiMath().getString(from: data))%"
        return (data >= 0) ? "+" + value : value
      } else {
        return SvetiMath().getString(from: data)
      }
    } else if let data = data as? String {
      return data
    }
    return "N/A".localized
  }
}
