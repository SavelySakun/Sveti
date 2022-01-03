import Foundation

enum TestHelper {
  static let isTestMode: Bool = (ProcessInfo.processInfo.environment["test_mode"] == "true")
}
