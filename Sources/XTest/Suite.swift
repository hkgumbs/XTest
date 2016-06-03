public struct Suite {
  private let listeners: [Listener]
  private let groups: [Group]

  public init(listeners: [Listener] = [DefaultFormat()], groups: Group...) {
    self.listeners = listeners
    self.groups = groups
  }

  public func run() {
    publish(event: .SuiteStarted)
    groups.forEach { run(group: $0) }
    publish(event: .SuiteEnded)
  }

  private func run(group: Group) {
    publish(event: .GroupStarted(group.describing))
    group.scenarios().forEach { run(test: $0.1, labeled: $0.0, within: group) }
    publish(event: .GroupEnded(group.describing))
  }

  private func run(test: Test, labeled label: String?, within group: Group) {
    publish(event: .TestStarted(label))
    group.before()
    let assert = Assert()
    test.scenario(assert)
    group.after()
    publish(event: .TestEnded(assert.results))
  }

  private func publish(event: Event) {
    listeners.forEach { listener in listener.on(event: event) }
  }
}
