public protocol Assert {
  func isTrue(_: Bool, error: String, file: String, line: Int)
}
