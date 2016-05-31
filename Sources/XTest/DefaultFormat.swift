class DefaultFormat: Listener {
  private var failures: [String] = []
  private var pending: [String] = []
  private var spec: String = ""
  private var test: String = ""

  func on(event: Event) {
    switch event {
    case .SpecStarted(let name):
      onTestStarted(name)
    case .TestStarted(let name):
      onTestStarted(name)
    case .TestEnded(let results):
      onTestEnded(results)
    case .SuiteEnded():
      onSuiteEnded()
    default:
      break
    }
  }

  private func onTestStarted(_ name: String) {
    spec = name
  }

  private func onTestStarted(_ name: String?) {
    test = name.map { "#\($0)" } ?? ""
  }

  private func onTestEnded(_ results: [Result]) {
    let failures = results.filter { result in !result.successful }

    if results.isEmpty { onTestIgnored() }
    else if failures.isEmpty { onTestPassed() }
    else { onTestFailed(result: failures.first!) }
  }

  private func onTestIgnored() {
    print("*", terminator: "")
    pending.append("    \(pending.count + 1)]  Pending: no assertion in '\(spec + test)'")
  }

  private func onTestPassed() {
    print(".", terminator: "")
  }

  private func onTestFailed(result: Result) {
    print("F", terminator: "")
    failures.append([
      "    \(failures.count + 1))  Failure in '\(spec + test)': \(result.message)",
      "        # \(result.file):\(result.line)",
    ].joined(separator: "\n"))
  }

  private func onSuiteEnded() {
    print("")
    print(failures.joined(separator: "\n\n"))
    print("")
    print(pending.joined(separator: "\n"))
  }
}
