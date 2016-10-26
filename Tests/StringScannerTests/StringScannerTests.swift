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
    
    if case let .value(str) = scanner.peek(length: 5) {
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
    
    if case let .value(str) = scanner.peek(untilRange: "x"..<"z") {
      XCTAssertEqual(str, "aaaa bbbb cccc ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(untilRange: "m"..<"o") {
      XCTAssertEqual(str, "aaaa bbbb cccc xa")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItPeeksForNonFoundStringInRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case .none = scanner.peek(untilRange: "0"..<"9") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanForStringUntilRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.scan(untilRange: "x"..<"z") {
      XCTAssertEqual(str, "aaaa bbbb cccc ")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(untilRange: "a"..<"m") {
      XCTAssertEqual(str, "x")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItScanForNonFoundStringForRange() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.scan(untilRange: "0"..<"9") {
      
    } else {
      XCTFail()
    }
  }

  func testItDoesNotScanBeyondLengthForRange() {
    let scanner = StringScanner(string: "Hello my name my omar8")
    
    if case let .value(str)  = scanner.scan(untilRange: "0"..<"9") {
      XCTAssertEqual(str, "Hello my name my omar")
    } else {
      XCTFail()
    }
  }
  
  func testItCanPeekRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.peek(forRange: "x"..<"z") {
      XCTAssertEqual(str, "aaaa bbbb cccc x")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.peek(forRange: "m"..<"o") {
      XCTAssertEqual(str, "aaaa bbbb cccc xam")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItPeeksForNonFoundStringToRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case .none = scanner.peek(forRange: "0"..<"9") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItCanScanForStringToRange() {
    let scanner = StringScanner(string: "aaaa bbbb cccc xame my omar")
    
    if case let .value(str) = scanner.scan(forRange: "x"..<"z") {
      XCTAssertEqual(str, "aaaa bbbb cccc x")
    } else {
      XCTFail()
    }
    
    if case let .value(str) = scanner.scan(forRange: "d"..."e") {
      XCTAssertEqual(str, "ame")
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotCrashIfItScanForNonFoundStringToRange() {
    let scanner = StringScanner(string: "Hello my name my omar")
    
    if case .none = scanner.scan(forRange: "0"..<"9") {
      
    } else {
      XCTFail()
    }
  }
  
  func testItDoesNotScanBeyondLengthToRange() {
    let scanner = StringScanner(string: "Hello my name my omar8")
    
    if case let .value(str)  = scanner.scan(forRange: "0"..."8") {
      XCTAssertEqual(str, "Hello my name my omar8")
    } else {
      XCTFail()
    }
    
    if case .end  = scanner.scan(forRange: "0"..."8") {
      
    } else {
      XCTFail()
    }
  }
  
  static var allTests : [(String, (StringScannerTests) -> () throws -> Void)] {
    return [
      ("testExample", testCanScanForCharacters),
    ]
  }
}
