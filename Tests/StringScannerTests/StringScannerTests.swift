import XCTest
@testable import StringScanner

class StringScannerTests: XCTestCase {
  
  func testCanScanForCharacters() {
    let scanner = StringScanner(string: "Hello my name is omar")
    let scanned = scanner.scan(length: 5)
    
    if case let .value(str) = scanned {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
  }
  
  func testItKeepsScanning() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(length: 4) {
      XCTAssertEqual(str, " my ")
    } else {
      XCTFail()
    }
  }
  
  func testItScansToTheLast() {
    let scanner = StringScanner(string: "Hello my")
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, " my")
    } else {
      XCTFail()
    }
  }
  
  func testItReturnEndIfOverScan() {
    let scanner = StringScanner(string: "Hello my")
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, " my")
    } else {
      XCTFail()
    }
    
    guard case .end = scanner.scan(length: 5) else {
      XCTFail()
      return
    }
  }
  
  func testItCanPeekAndNotProgress() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
  }
  
  func testItCanDropAndPeek() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    XCTAssertTrue(scanner.drop(length: 5))
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, " my n")
    } else {
      XCTFail()
    }
  }
  
  func testItCantDropAfterStringEnd() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    XCTAssertFalse(scanner.drop(length: 100))
    
    if case .value = scanner.peek(length: 5) {
      XCTFail()
    } else {
      
    }
  }
  
  func testItCanPeekAndScanProgress() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.peek(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, "Hello")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(length: 5) {
      XCTAssertEqual(str, " my n")
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekUntilAPattern() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.peek(untilPattern: "my") {
      XCTAssertEqual(str, "Hello ")
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanUntilAPattern() {
    let scanner = StringScanner(string: "Hello my name is omar")
    
    if case let .value(str) = scanner.scan(untilPattern: "my") {
      XCTAssertEqual(str, "Hello ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(untilPattern: "(is|ss)") {
      XCTAssertEqual(str, "my name ")
    } else {
      XCTFail()
    }
    
  }
  
  func XtestItCanPeekUntilAPatternNotGreedy() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.peek(untilPattern: "my") {
      XCTAssertEqual(str, "Hello ")
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekUntilAString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.peek(untilString: "name") {
      XCTAssertEqual(str, "Hello my ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(untilString: "my omar") {
      XCTAssertEqual(str, "Hello my name ")
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanUntilAString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.scan(untilString: "name") {
      XCTAssertEqual(str, "Hello my ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(untilString: "my omar") {
      XCTAssertEqual(str, "name ")
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanUntilAStringAndTheEnd() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.scan(untilString: "name") {
      XCTAssertEqual(str, "Hello my ")
    } else {
      XCTFail()
    }
    
    if case .none = scanner.scan(untilString: "xxx") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekForString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.peek(forString: "Hello m") {
      XCTAssertEqual(str, "Hello m")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(forString: "Hello my name") {
      XCTAssertEqual(str, "Hello my name")
    } else {
      XCTFail()
    }
  }

  func testItDoesNotCrashIfItPeeksForNonFoundString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.peek(forString: "my") {
      
    } else {
      XCTFail()
    }
  }

  func testItCanScanForString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str) = scanner.scan(forString: "Hello m") {
      XCTAssertEqual(str, "Hello m")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(forString: "y name my") {
      XCTAssertEqual(str, "y name my")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItScanForNonFoundString() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.scan(forString: "my") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotScanBeyondLength() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case let .value(str)  = scanner.scan(forString: "Hello my name my omar") {
      XCTAssertEqual(str, "Hello my name my omar")
    } else {
      XCTFail()
    }
    
    if case .end = scanner.scan(forString: "a") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekUntilRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.peek(untilCharacterSet: .range("x"..<"z")) {
      XCTAssertEqual(str, "aaaa bbbb cccc ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(untilCharacterSet: .range("m"..<"o")) {
      XCTAssertEqual(str, "aaaa bbbb cccc xa")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItPeeksForNonFoundStringInRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case .none = scanner.peek(untilCharacterSet: .range("0"..<"9")) {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanForStringUntilRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.scan(untilCharacterSet: .range("x"..<"z")) {
      XCTAssertEqual(str, "aaaa bbbb cccc ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(untilCharacterSet: .range("a"..<"m")) {
      XCTAssertEqual(str, "x")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItScanForNonFoundStringForRange() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.scan(untilCharacterSet: .range("0"..<"9")) {
      
    } else {
      XCTFail()
    }
  }

  func testItDoesNotScanBeyondLengthForRange() {
    let scanner = StringScanner(string: "Hello my name my omar8")
    
    if case let .value(str)  = scanner.scan(untilCharacterSet: .range("0"..<"9")) {
      XCTAssertEqual(str, "Hello my name my omar")
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.peek(forCharacterSet: .range("x"..<"z")) {
      XCTAssertEqual(str, "aaaa bbbb cccc x")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(forCharacterSet: .range("m"..<"o")) {
      XCTAssertEqual(str, "aaaa bbbb cccc xam")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItPeeksForNonFoundStringToRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case .none = scanner.peek(forCharacterSet: .range("0"..<"9")) {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanForStringToRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.scan(forCharacterSet: .range("x"..<"z")) {
      XCTAssertEqual(str, "aaaa bbbb cccc x")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(forCharacterSet: .range("d"..."e")) {
      XCTAssertEqual(str, "ame")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItScanForNonFoundStringToRange() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.scan(forCharacterSet: .range("0"..<"9")) {
      
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotScanBeyondLengthToRange() {
    let scanner = StringScanner(string: "Hello my name my omar8")
    
    if case let .value(str)  = scanner.scan(forCharacterSet: .range("0"..."8")) {
      XCTAssertEqual(str, "Hello my name my omar8")
    } else {
      XCTFail()
    }
    
    if case .end  = scanner.scan(forCharacterSet: .range("0"..."8")) {
      
    } else {
      XCTFail()
    }
  }
  
  func testItReturnsEmptyString() {
    let scanner = StringScanner(string: "Hello my name my omar8")
    
    if case let .value(str)  = scanner.scan(forCharacterSet: .range("0"..."8")) {
      XCTAssertEqual(str, "Hello my name my omar8")
    } else {
      XCTFail()
    }
    
    XCTAssertEqual(scanner.remainingString, "")
  }
  
  static var allTests : [(String, (StringScannerTests) -> () throws -> Void)] {
    return [
      ("testCanScanForCharacters", testCanScanForCharacters),
      ("testItKeepsScanning", testItKeepsScanning),
      ("testItScansToTheLast", testItScansToTheLast),
      ("testItReturnEndIfOverScan", testItReturnEndIfOverScan),
      ("testItCanPeekAndNotProgress", testItCanPeekAndNotProgress),
      ("testItCanDropAndPeek", testItCanDropAndPeek),
      ("testItCantDropAfterStringEnd", testItCantDropAfterStringEnd),
      ("testItCanPeekAndScanProgress", testItCanPeekAndScanProgress),
      ("testItCanPeekUntilAPattern", testItCanPeekUntilAPattern),
      ("testItCanScanUntilAPattern", testItCanScanUntilAPattern),
//      ("XtestItCanPeekUntilAPatternNotGreedy", XtestItCanPeekUntilAPatternNotGreedy),
      ("testItCanPeekUntilAString", testItCanPeekUntilAString),
      ("testItCanScanUntilAString", testItCanScanUntilAString),
      ("testItCanScanUntilAStringAndTheEnd", testItCanScanUntilAStringAndTheEnd),
      ("testItCanPeekForString", testItCanPeekForString),
      ("testItDoesNotCrashIfItPeeksForNonFoundString", testItDoesNotCrashIfItPeeksForNonFoundString),
      ("testItCanScanForString", testItCanScanForString),
      ("testItDoesNotCrashIfItScanForNonFoundString", testItDoesNotCrashIfItScanForNonFoundString),
      ("testItDoesNotScanBeyondLength", testItDoesNotScanBeyondLength),
      ("testItCanPeekUntilRange", testItCanPeekUntilRange),
      ("testItDoesNotCrashIfItPeeksForNonFoundStringInRange", testItDoesNotCrashIfItPeeksForNonFoundStringInRange),
      ("testItCanScanForStringUntilRange", testItCanScanForStringUntilRange),
      ("testItDoesNotCrashIfItScanForNonFoundStringForRange", testItDoesNotCrashIfItScanForNonFoundStringForRange),
      ("testItDoesNotScanBeyondLengthForRange", testItDoesNotScanBeyondLengthForRange),
      ("testItCanPeekRange", testItCanPeekRange),
      ("testItDoesNotCrashIfItPeeksForNonFoundStringToRange", testItDoesNotCrashIfItPeeksForNonFoundStringToRange),
      ("testItCanScanForStringToRange", testItCanScanForStringToRange),
      ("testItDoesNotCrashIfItScanForNonFoundStringToRange", testItDoesNotCrashIfItScanForNonFoundStringToRange),
      ("testItDoesNotScanBeyondLengthToRange", testItDoesNotScanBeyondLengthToRange),
      ("testItReturnsEmptyString", testItReturnsEmptyString)
    ]
  }
}
