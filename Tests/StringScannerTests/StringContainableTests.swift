import XCTest
@testable import StringScanner

class StringContainableTests: XCTestCase {
  
  func testThatItMatchSmallLetters() {
    let b1 = CharacterSet.smallLetters.containable.contains(character:  "a")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.smallLetters.containable.contains(character:  Character("c"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.smallLetters.containable.contains(character:  "z")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.smallLetters.containable.contains(character:  "F")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchCapitalLetters() {
    let b1 = CharacterSet.capitalLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.capitalLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.capitalLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.capitalLetters.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAllLetters() {
    let b1 = CharacterSet.allLetters.containable.contains(character:  "A")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.allLetters.containable.contains(character:  Character("C"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.allLetters.containable.contains(character:  "Z")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.allLetters.containable.contains(character:  "a")
    XCTAssertTrue(b4)
    
    let b5 = CharacterSet.allLetters.containable.contains(character:  Character("b"))
    XCTAssertTrue(b5)
    
    let b6 = CharacterSet.allLetters.containable.contains(character:  "z")
    XCTAssertTrue(b6)
    
    let b7 = CharacterSet.allLetters.containable.contains(character:  "1")
    XCTAssertFalse(b7)
  }
  
  func testThatItMatchNumbersLetters() {
    let b1 = CharacterSet.numbers.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.numbers.containable.contains(character:  Character("0"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.numbers.containable.contains(character:  "9")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.numbers.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchSpaceLetters() {
    let b1 = CharacterSet.space.containable.contains(character:  " ")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.space.containable.contains(character:  Character(" "))
    XCTAssertTrue(b2)
    
    let b4 = CharacterSet.space.containable.contains(character:  "f")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchAlphaNumericLetters() {
    let b1 = CharacterSet.alphaNumeric.containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.alphaNumeric.containable.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.alphaNumeric.containable.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.alphaNumeric.containable.contains(character:  " ")
    XCTAssertFalse(b4)
  }
  
  func testThatItMatchCharactersInString() {
    let b1 = CharacterSet.charactersInString("1Ac").containable.contains(character:  "1")
    XCTAssertTrue(b1)
    
    let b2 = CharacterSet.charactersInString("1Ac").containable.contains(character:  Character("A"))
    XCTAssertTrue(b2)
    
    let b3 = CharacterSet.charactersInString("1Ac").containable.contains(character:  "c")
    XCTAssertTrue(b3)
    
    let b4 = CharacterSet.charactersInString("1Ac").containable.contains(character:  " ")
    XCTAssertFalse(b4)
    
    let b5 = CharacterSet.charactersInString("1Ac").containable.contains(character:  "w")
    XCTAssertFalse(b5)
  }
  
  func testItCanJoinContainable() {
    let rs = CharacterSet.smallLetters.join(characterSet: CharacterSet.charactersInString("AB"))
    
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
