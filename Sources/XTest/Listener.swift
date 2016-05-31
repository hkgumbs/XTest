public enum Event {
  case SuiteStarted
  case SpecStarted(String)
  case TestStarted(String?)
  case TestEnded([Assert.Result])
  case SpecEnded(String)
  case SuiteEnded
}

public protocol Listener {
  func on(event: Event)
}
