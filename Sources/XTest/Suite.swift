public struct Suite {
  private class AssertDelegate: Assert {
    var results: [Result] = []
    func accumulate(result: Result) {
      results.append(result)
    }
  }

  private let listeners: [Listener]
  private let specs: [Spec]

  public init(listeners: [Listener] = [DefaultFormat()], specs: Spec...) {
    self.listeners = listeners
    self.specs = specs
  }

  public func run() {
    publish(event: .SuiteStarted)
    for spec in specs {
      let name = String(spec.dynamicType)
      publish(event: .SpecStarted(name))
      for (label, test) in spec.scenarios() {
        publish(event: .TestStarted(label))
        spec.before()
        let assert = AssertDelegate()
        test.scenario(assert)
        spec.after()
        publish(event: .TestEnded(assert.results))
      }
      publish(event: .SpecEnded(name))
    }
    publish(event: .SuiteEnded)
  }

  private func publish(event: Event) {
    listeners.forEach { listener in listener.on(event: event) }
  }
}
