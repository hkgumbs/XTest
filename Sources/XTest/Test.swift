public struct Test {
  let scenario: ((Assert) -> Void)

  public init(scenario: ((Assert) -> Void)) {
    self.scenario = scenario
  }
}
