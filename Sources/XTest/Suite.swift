public struct Suite {
  private let listeners: [Listener]
  private let groups: [Group]

  public init(listeners: [Listener] = [DefaultFormat()], groups: Group...) {
    self.listeners = listeners
    self.groups = groups
  }

  public func run() {
    publish(event: .SuiteStarted)
    for group in groups {
      let name = String(group.dynamicType)
      publish(event: .GroupStarted(name))
      for (label, test) in group.scenarios() {
        publish(event: .TestStarted(label))
        group.before()
        let assert = Assert()
        test.scenario(assert)
        group.after()
        publish(event: .TestEnded(assert.results))
      }
      publish(event: .GroupEnded(name))
    }
    publish(event: .SuiteEnded)
  }

  private func publish(event: Event) {
    listeners.forEach { listener in listener.on(event: event) }
  }
}
