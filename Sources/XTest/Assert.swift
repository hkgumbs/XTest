public struct Result {
  let successful: Bool
  let message: String
  let file: String
  let line: Int
}

public protocol Assert {
  func accumulate(result: Result)
}

extension Assert {
  public func that(_ successful: Bool, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected true but got false"
    accumulate(result: Result(successful: successful, message: message, file: file, line: line))
  }

  public func that<E: Equatable>(_ first: E, equals second: E, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected \(first) to equal \(second)"
    accumulate(result: Result(successful: first == second, message: message, file: file, line: line))
  }

  public func that<E: Equatable, S: Sequence where S.Iterator.Element == E>(sequence: S, contains element: E, message provided: String? = nil, file: String = #file, line: Int = #line) {
    let message = provided ?? "Expected \(sequence) to contain \(element)"
    accumulate(result: Result(successful: sequence.contains { $0 == element }, message: message, file: file, line: line))
  }
}
