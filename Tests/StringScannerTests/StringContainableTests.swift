import XCTest
@testable import StringScanner

class StringContainableTests: XCTestCase {
  
  func testThatItMatchSmallLetters() {
    let b1 = RangeSet.smallLetters.containable.contains(character:  "a")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.smallLetters.containable.contains(character:  Character("c"))
    XCTAssertTrue(b2)
    
    let b3 = RangeSet.smallLetters.containable.contains(character:  "z")
    XCTAssertTrue(b3)
    
    let b4 = RangeSet.smallLetters.containable.contains(character:  "F")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchCapitalLetters() {
    let b1 = RangeSet.capitalLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.capitalLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = RangeSet.capitalLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = RangeSet.capitalLetters.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAllLetters() {
    let b1 = RangeSet.allLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.allLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = RangeSet.allLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = RangeSet.allLetters.containable.contains(character:  "a")
    XCTAssertTrue(b4)
    
    let b5 = RangeSet.allLetters.containable.contains(character:  Character("b"))
    XCTAssertTrue(b5)
    
    let b6 = RangeSet.allLetters.containable.contains(character:  "z")
    XCTAssertTrue(b6)
    
    let b7 = RangeSet.allLetters.containable.contains(character:  "1")
    XCTAssertFalse(b7)
  }
  
  func testThatItMatchNumbersLetters() {
    let b1 = RangeSet.numbers.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.numbers.containable.contains(character:  Character("0"))
    XCTAssertTrue(b2)
    
    let b3 = RangeSet.numbers.containable.contains(character:  "9")
    XCTAssertTrue(b3)
    
    let b4 = RangeSet.numbers.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchSpaceLetters() {
    let b1 = RangeSet.space.containable.contains(character:  " ")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.space.containable.contains(character:  Character(" "))
    XCTAssertTrue(b2)
    
    let b4 = RangeSet.space.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAlphaNumericLetters() {
    let b1 = RangeSet.alphaNumeric.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = RangeSet.alphaNumeric.containable.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = RangeSet.alphaNumeric.containable.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = RangeSet.alphaNumeric.containable.contains(character:  " ")
    XCTAssertFalse(b4)
  }
  
  static var allTests : [(String, (StringContainableTests) -> () throws -> Void)] {
    return [
      ("testThatItMatchSmallLetters", testThatItMatchSmallLetters),
      ("testThatItMatchCapitalLetters", testThatItMatchCapitalLetters),
      ("testThatItMatchAllLetters", testThatItMatchAllLetters),
      ("testThatItMatchNumbersLetters", testThatItMatchNumbersLetters),
      ("testThatItMatchSpaceLetters", testThatItMatchSpaceLetters),
      ("testThatItMatchAlphaNumericLetters", testThatItMatchAlphaNumericLetters)
    ]
  }

}
