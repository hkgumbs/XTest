public enum Test {
  case Case((Assert) throws -> ())
  case Before(() -> ())
  case After(() -> ())
}
