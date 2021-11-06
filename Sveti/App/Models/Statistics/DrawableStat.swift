import Foundation

class DrawableStat {
  var splitDate = SplitDate()
  var averageEmotional: Double = 0.0
  var averagePhysical: Double = 0.0
  var averageState: Double = 0.0

  init(_ statDays: [StatDay], _ date: Date) {
    self.splitDate = SplitDate(rawDate: date)

    var totalAverageEmotional: Double = 0.0
    var totalAveragePhysical: Double = 0.0
    var totalAverageState: Double = 0.0

    statDays.forEach { statDay in
      totalAverageEmotional += getAverage(data: statDay.emotionalStates.sorted())
      totalAveragePhysical += getAverage(data: statDay.phyzicalStates.sorted())
      let averageStateFloat = MathHelper().calculateAverage([Float(totalAverageEmotional), Float(totalAveragePhysical)])
      totalAverageState += Double(averageStateFloat)
    }

    self.averageEmotional = totalAverageEmotional / Double(statDays.count)
    self.averagePhysical = totalAveragePhysical / Double(statDays.count)
    self.averageState = totalAverageState / Double(statDays.count)
  }

  private func getAverage(data: [Float]) -> Double {
    let averageFloat = MathHelper().calculateAverage(data)
    return Double(averageFloat)
  }
}
