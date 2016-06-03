public class Assert {
  public typealias Result = (
    successful: Bool,
    message: String,
    file: String,
    line: Int
  )

  var results: [Result] = []

  public func that(_ successful: Bool, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected true but got false"
    results.append((successful: successful, message: message, file: file, line: line))
  }

  public func that<E: Equatable>(_ first: E?, equals second: E?, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected \(first) to equal \(second)"
    results.append((successful: first == second, message: message, file: file, line: line))
  }

  public func that<E: Equatable, S: Sequence where S.Iterator.Element == E>(sequence: S, contains element: E, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected \(sequence) to contain \(element)"
    results.append((successful: sequence.contains { $0 == element }, message: message, file: file, line: line))
  }
}
