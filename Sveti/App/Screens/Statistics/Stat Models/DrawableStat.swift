import Foundation
import SigmaSwiftStatistics

struct MoodStat {
  var physical: Double = 0.0
  var emotional: Double = 0.0
  var all: Double = 0.0

  mutating func set(_ states: [Double?]) {
    guard let physical = states[safe: 0],
          let emotional = states[safe: 1],
          let all = states[safe: 2] else { return }

    self.emotional = emotional ?? 0.0
    self.physical = physical ?? 0.0
    self.all = all ?? 0.0
  }

  func get(_ type: StatType) -> Double {
    switch type {
    case .emotional:
      return emotional
    case .physical:
      return physical
    case .all:
      return all
    }
  }
}

class DrawableStat {
  var splitDate = SplitDate()
  var totalNotes: Double = 0.0
  var averageMood = MoodStat()
  var maxMood = MoodStat()
  var minMood = MoodStat()
  var stability: MoodStat?

  private let math = SvetiMath()
  private let statDaysInstruments = StatDaysInstruments()

  init(_ statDays: [StatDay], _ date: Date) {
    splitDate = SplitDate(rawDate: date)

    setAverages(from: statDays)
    setMaxs(from: statDays)
    setMins(from: statDays)
    setTotalNotes(from: statDays)
    setStability(from: statDays)
  }

  private func getStates(from statDays: [StatDay]) -> [[Double]] {
    let physicalStates = statDays.flatMap { $0.phyzicalStates }
    let emotionalStates = statDays.flatMap { $0.emotionalStates }
    let allStates = statDays.flatMap { statDaysInstruments.getAverageMoods(from: $0) }
    return [physicalStates, emotionalStates, allStates]
  }

  private func set(moodStat: inout MoodStat, with statDays: [StatDay], operation: (([Double]) -> Double?)) {
    let states = getStates(from: statDays)
    let values = states.map { operation($0) }
    moodStat.set(values)
  }

  private func setAverages(from statDays: [StatDay]) {
    set(moodStat: &averageMood, with: statDays) { math.average($0) }
  }

  private func setMaxs(from statDays: [StatDay]) {
    set(moodStat: &maxMood, with: statDays) { $0.max() }
  }

  private func setMins(from statDays: [StatDay]) {
    set(moodStat: &minMood, with: statDays) { $0.min() }
  }

  private func setTotalNotes(from statDays: [StatDay]) {
    statDays.forEach { self.totalNotes += $0.totalNotes }
  }

  private func setStability(from statDays: [StatDay]) {
    let states = getStates(from: statDays)
    let stabilities = states.map { math.calculateStability(from: $0) }

    guard let phyzStates = states[safe: 0], phyzStates.count > 1 else { return }
    stability = MoodStat()
    stability?.set(stabilities)
  }
}
