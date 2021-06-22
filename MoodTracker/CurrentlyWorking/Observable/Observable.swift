import UIKit

class Observable<T> {

  var value: T? {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T?) {
    self.value = value
  }

  private var listener: ((T?) -> Void)?

  func bind(_ listener: @escaping (T?) -> Void) {
    listener(value)
    self.listener = listener
  }

}

class Observer<T> {

  var eventTypes: T?

  init(_ type: T.Type) {
    guard let type = type.self as? T else { return }
    self.eventTypes = type
  }

  func notify(_ event: T) {

    switch eventTypes {
    default:
      return
    }

  }

}
