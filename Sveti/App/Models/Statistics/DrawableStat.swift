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
    let math = MathHelper()

    statDays.forEach { statDay in
      totalAverageEmotional += math.average(statDay.emotionalStates.sorted())
      totalAveragePhysical += math.average(statDay.phyzicalStates.sorted())

      let totalStat = [statDay.emotionalStates.sorted(),
                       statDay.phyzicalStates.sorted()].flatMap { $0 }

      totalAverageState += math.average(totalStat)
    }

    let totalStatDays = Double(statDays.count)
    self.averageEmotional = totalAverageEmotional / totalStatDays
    self.averagePhysical = totalAveragePhysical / totalStatDays
    self.averageState = totalAverageState / totalStatDays
  }
}
