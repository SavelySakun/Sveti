import Foundation

class DrawableStatDay {
  var date = Date()
  var averageEmotional: Double = 0.0
  var averagePhysical: Double = 0.0
  var averageState: Double = 0.0

  init(statDay: StatDay) {
    self.averageEmotional = getAverage(data: statDay.emotionalStates.sorted())
    self.averagePhysical = getAverage(data: statDay.phyzicalStates.sorted())
    let averageStateFloat = MathHelper().calculateAverage([Float(averageEmotional), Float(averagePhysical)])
    self.averageState = Double(averageStateFloat)
  }

  private func getAverage(data: [Float]) -> Double {
    let averageFloat = MathHelper().calculateAverage(data)
    return Double(averageFloat)
  }
}
