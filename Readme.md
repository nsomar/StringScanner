# StringScanner

[![Build Status](https://travis-ci.org/oarrabi/StringScanner.svg?branch=master)](https://travis-ci.org/oarrabi/StringScanner)
[![codecov](https://codecov.io/gh/oarrabi/StringScanner/branch/master/graph/badge.svg)](https://codecov.io/gh/oarrabi/StringScanner)
[![Platform](https://img.shields.io/badge/platform-osx-lightgrey.svg)](https://travis-ci.org/oarrabi/StringScanner)
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://travis-ci.org/oarrabi/StringScanner)
[![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://travis-ci.org/oarrabi/StringScanner)
[![CocoaPods](https://img.shields.io/cocoapods/v/StringScanner.svg)](https://cocoapods.org/pods/StringScanner)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`StringScanner` is a native swift implementation of a string scanner; a replacement of `NSScanner`. 

`StringScanner` has been built by using swfit standard library only, and it does not depend on libFoundation. In that way it can be built on mac and linux, and can be build with static compilation in mind.

## Usage

`StringScanner` is initialized with a string, it has an internal index that get progressed as the string is scanned.

`StringScanner` has two operations, `peek` and `scan`.
- `scan` returns a string and advances the internal string index.
- `peek` returns a string but does not progress the internal string index.

The result of scan or peek is a `ScannerResult`, which has the following values:
- ScannerResult.none: no string was found
- ScannerResult.end: the scanner has reached the end of the string
- ScannerResult.value(str): the string is found

### Scan

#### Scan for length
Scanning for a given length

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.scan(length: 5)
```

Returns `ScannerResult.("Hello")`

#### Scan until patter
Scan the string until a pattern is found

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.scan(untilPattern: "my")
```

Returns `ScannerResult.("Hello ")`

#### Scan until string
Scan the string until a string is found

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.scan(untilString: "my")
```

Returns `ScannerResult.("Hello ")`

#### Scan for a String
Scan the string for a given string. If the search string is found, it gets rerurned and the scanner index is advanced.

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.scan(forString: "Hello mymy")
```

Returns `ScannerResult.("Hello my ")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

#### Scan until character set
Scan the string until a character set of strings is found. If the character set is found, it gets rerurned and the scanner index is advanced.

```swift
let scanner = StringScanner(string: "This is a test 1234")
scanner.scan(untilCharacterSet: .range("1"..<"4"))
```

Returns `ScannerResult.("This is a test ")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

#### Scan for character set
Scan the string until a character set of strings is found and return the string and the found character set. If the character set is found, it gets rerurned and the scanner index is advanced.

```swift
let scanner = StringScanner(string: "This is a test 1234")
scanner.scan(forCharacterSet: .range("1"..<"4"))
```

Returns `ScannerResult.("This is a test 1")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

### Peek

#### Peek for length
Peeking for a given length

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.peek(length: 5)
```

Returns `ScannerResult.("Hello")`

#### Peek until patter
Peek the string until a pattern is found

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.peek(untilPattern: "my")
```

Returns `ScannerResult.("Hello ")`

#### Peek until string
Peek the string until a string is found

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.peek(untilString: "my")
```

Returns `ScannerResult.("Hello ")`

#### Peek for a String
Peek the string for a given string. If the search string is found, it gets rerurned.

```swift
let scanner = StringScanner(string: "Hello my name is omar")
scanner.peek(forString: "Hello mymy")
```

Returns `ScannerResult.("Hello my ")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

#### Peek until character set
Peek the string until a character set of strings is found. If the character set is found, it gets rerurned.

```swift
let scanner = StringScanner(string: "This is a test 1234")
scanner.peek(untilCharacterSet: .range("1"..<"4"))
```

Returns `ScannerResult.("This is a test ")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

#### Peek for character set
Scan the string until a character set of strings is found and return the string and the found character set. If the character set is found, it gets rerurned.

```swift
let scanner = StringScanner(string: "This is a test 1234")
scanner.peek(forCharacterSet: .range("1"..<"4"))
```

Returns `ScannerResult.("This is a test 1")`

If we scan for a non exsisting string, we will get `ScannerResult.none`

### Scan for a combination of character set
`CharacterSet` provide ready made character sets that represent the most used ones: such as `.allLetters`, `smallLetters`, `alphaNumeric`.

Character set can be joined togther. For example we can search for all numbers + ABC

```swift
let scanner = StringScanner(string: "This is a test 1234")
let set = CharacterSet.numbers.join(characterSet: CharacterSet.string("ABC"))
```

The we can scan until we find that set

```swift
scanner.scan(untilCharacerSet: set)
```

This returns `This is a test `

## Installation
You can install Swiftline using CocoaPods, carthage and Swift package manager

### CocoaPods
    use_frameworks!
    pod 'StringScanner'

### Carthage
    github 'oarrabi/StringScanner'

### Swift Package Manager
Add swiftline as dependency in your `Package.swift`

```
  import PackageDescription

  let package = Package(name: "YourPackage",
    dependencies: [
      .Package(url: "https://github.com/oarrabi/StringScanner.git", majorVersion: 0),
    ]
  )
```

## Tests
Tests can be found [here](https://github.com/oarrabi/StringScanner/tree/master/Tests). 

Run them with 
```
swift test
```
