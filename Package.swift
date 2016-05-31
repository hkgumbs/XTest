import PackageDescription

let package = Package(
  targets: [
    Target(name: "XTest"),
    Target(name: "Sample", dependencies: [.Target(name: "XTest")])
  ]
)
