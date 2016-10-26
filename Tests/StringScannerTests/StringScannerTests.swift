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
  
  
  static var allTests : [(String, (StringScannerTests) -> () throws -> Void)] {
    return [
      ("testExample", testCanScanForCharacters),
    ]
  }
}
