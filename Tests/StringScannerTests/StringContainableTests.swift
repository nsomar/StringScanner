import XCTest
@testable import StringScanner

class StringContainableTests: XCTestCase {
  
  func testThatItMatchSmallLetters() {
    let b1 = CharactersSet.smallLetters.containable.contains(character:  "a")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.smallLetters.containable.contains(character:  Character("c"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.smallLetters.containable.contains(character:  "z")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.smallLetters.containable.contains(character:  "F")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchCapitalLetters() {
    let b1 = CharactersSet.capitalLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.capitalLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.capitalLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.capitalLetters.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAllLetters() {
    let b1 = CharactersSet.allLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.allLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.allLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.allLetters.containable.contains(character:  "a")
    XCTAssertTrue(b4)
    
    let b5 = CharactersSet.allLetters.containable.contains(character:  Character("b"))
    XCTAssertTrue(b5)
    
    let b6 = CharactersSet.allLetters.containable.contains(character:  "z")
    XCTAssertTrue(b6)
    
    let b7 = CharactersSet.allLetters.containable.contains(character:  "1")
    XCTAssertFalse(b7)
  }
  
  func testThatItMatchNumbersLetters() {
    let b1 = CharactersSet.numbers.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.numbers.containable.contains(character:  Character("0"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.numbers.containable.contains(character:  "9")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.numbers.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchSpaceLetters() {
    let b1 = CharactersSet.space.containable.contains(character:  " ")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.space.containable.contains(character:  Character(" "))
    XCTAssertTrue(b2)
    
    let b4 = CharactersSet.space.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAlphaNumericLetters() {
    let b1 = CharactersSet.alphaNumeric.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.alphaNumeric.containable.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.alphaNumeric.containable.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.alphaNumeric.containable.contains(character:  " ")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchCharactersInString() {
    let b1 = CharactersSet.string("1Ac").containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharactersSet.string("1Ac").containable.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = CharactersSet.string("1Ac").containable.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = CharactersSet.string("1Ac").containable.contains(character:  " ")
    XCTAssertFalse(b4)
    
    let b5 = CharactersSet.string("1Ac").containable.contains(character:  "w")
    XCTAssertFalse(b5)
  }
  
  func testItCanJoinContainable() {
    let rs = CharactersSet.smallLetters.join(characterSet: CharactersSet.string("AB"))
    
    let b1 = rs.contains(character:  "a")
    XCTAssertTrue(b1)
    
    let b2 = rs.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = rs.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = rs.contains(character:  "4")
    XCTAssertFalse(b4)
    
    let b5 = rs.contains(character:  "C")
    XCTAssertFalse(b5)
  }
  
  static var allTests : [(String, (StringContainableTests) -> () throws -> Void)] {
    return [
      ("testThatItMatchSmallLetters", testThatItMatchSmallLetters),
      ("testThatItMatchCapitalLetters", testThatItMatchCapitalLetters),
      ("testThatItMatchAllLetters", testThatItMatchAllLetters),
      ("testThatItMatchNumbersLetters", testThatItMatchNumbersLetters),
      ("testThatItMatchCharactersInString", testThatItMatchCharactersInString),
      ("testThatItMatchSpaceLetters", testThatItMatchSpaceLetters),
      ("testItCanJoinContainable", testItCanJoinContainable),
      ("testThatItMatchAlphaNumericLetters", testThatItMatchAlphaNumericLetters)
    ]
  }

}
