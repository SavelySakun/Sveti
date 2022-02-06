import Foundation

class SvetiAnalytics {
  static func log(_ event: MainEvents, params: [String : Any]? = nil) {
    guard !TestHelper.isTestMode else { return }
    // no analytics in demo
    return
  }
}
