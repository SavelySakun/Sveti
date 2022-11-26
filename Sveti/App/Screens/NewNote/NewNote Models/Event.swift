import Foundation

protocol EventProtocol {
    var type: String { get set }
    var value: Any { get set }
}

class Event: EventProtocol {
    var type: String
    var value: Any

    init(type: String, value: Any) {
        self.type = type
        self.value = value
    }
}
