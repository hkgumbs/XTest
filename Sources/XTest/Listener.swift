public enum Event {
  case SuiteStarted
  case GroupStarted(String)
  case TestStarted(String?)
  case TestEnded([Assert.Result])
  case GroupEnded(String)
  case SuiteEnded
}

public protocol Listener {
  func on(event: Event)
}
