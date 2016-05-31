# XTest
## Swift xUnit testing without XCode

#### `Sources/Sample/MySpec.swift`
```swift
import XTest

struct MySpec: Group {
  static var data: [Int] = []

  func before() {
    // optional, runs before every test
    // after() is also optional
    MySpec.data = [1, 2, 3]
  }

  let mutatingDataDoesNotAffectOtherTests = Test { assert in
    assert.that(3 == data.popLast())
  }

  let arrayContainsElement = Test { assert in
    assert.that(sequence: data, contains: 2)
  }

  let thingsAreNotEqual = Test { assert in
    assert.that(data.first!, equals: data.last!, message: "Look, custom messages!")
  }

  let testWithNoAssertions = Test { _ in }
}
```

#### `Sources/Sample/main.swift`
```swift
import XTest

Suite(groups: MySpec()).run()
```

#### Output
```bash
$ .build/debug/Sample
..F*
    1)  Failure in 'MySpec#thingsAreNotEqual': Look, custom messages!
        # /app/Sources/Sample/MySpec.swift:21

    1]  Pending: no assertion in 'MySpec#testWithNoAssertions'
```


🍏 | 🐧
