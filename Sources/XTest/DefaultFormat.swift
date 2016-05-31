class DefaultFormat: Listener {
  private var passedCount: Int = 0
  private var failures: [String] = []
  private var pending: [String] = []
  private var currentGroup: String = ""
  private var currentTest: String = ""

  func on(event: Event) {
    switch event {
    case .GroupStarted(let name):
      onGroupStarted(name)
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

  private func onGroupStarted(_ name: String) {
    currentGroup = name
  }

  private func onTestStarted(_ name: String?) {
    currentTest = name.map { "#\($0)" } ?? ""
  }

  private func onTestEnded(_ results: [Assert.Result]) {
    let failures = results.filter { result in !result.successful }

    if results.isEmpty { onTestIgnored() }
    else if failures.isEmpty { onTestPassed() }
    else { onTestFailed(result: failures.first!) }
  }

  private func onTestIgnored() {
    print("*", terminator: "")
    pending.append("    \(pending.count + 1)]  Pending: no assertion in '\(currentGroup + currentTest)'")
  }

  private func onTestPassed() {
    print(".", terminator: "")
    passedCount += 1
  }

  private func onTestFailed(result: Assert.Result) {
    print("F", terminator: "")
    failures.append([
      "    \(failures.count + 1))  Failure in '\(currentGroup + currentTest)': \(result.message)",
      "        # \(result.file):\(result.line)",
    ].joined(separator: "\n"))
  }

  private func onSuiteEnded() {
    let spacing = "\n\n"
    let summary = "  \(passedCount)/\(passedCount + failures.count) passed."
    let output = (failures + pending).joined(separator: spacing)
    print(spacing, output, spacing, summary, spacing)
  }
}
