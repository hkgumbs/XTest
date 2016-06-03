public protocol Group {
  func before()
  func after()
}

public extension Group {
  func before() {}
  func after() {}
}

extension Group {
  var describing: String { return String(self.dynamicType) }

  func scenarios() -> [(String?, Test)] {
    return Mirror(reflecting: self).children
      .flatMap { child in (child.value as? Test).map { test in (label: child.label, test: test) } }
  }
}
