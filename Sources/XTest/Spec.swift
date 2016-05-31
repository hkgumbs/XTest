public protocol Spec {
  func before()
  func after()
}

public extension Spec {
  func before() {}
  func after() {}
}

extension Spec {
  func scenarios() -> [(String?, Test)] {
    return Mirror(reflecting: self).children
      .flatMap { child in (child.value as? Test).map { test in (label: child.label, test: test) } }
  }
}
