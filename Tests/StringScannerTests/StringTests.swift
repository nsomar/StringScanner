//
//  StringTests.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 30/10/2016.
//
//

import XCTest
@testable import StringScanner

class StringTests: XCTestCase {
  
  func testItSearchesForAString() {
    let s = "My name is omar"
    let i = s.find(string: "name")!
    
    let d = s.distance(from: s.startIndex, to: i)
    
    XCTAssertEqual(d, 3)
  }
  
  func testItSearchesForAStringAtStart() {
    let s = "My name is omar"
    let i = s.find(string: "My")!
    
    let d = s.distance(from: s.startIndex, to: i)
    
    XCTAssertEqual(d, 0)
  }
  
  func testItSearchesForAStringAtEnd() {
    let s = "My name is omar"
    let i = s.find(string: "omar")!
    
    let d = s.distance(from: s.startIndex, to: i)
    
    XCTAssertEqual(d, 11)
  }
  
  func testItReturnNilIfNotFound() {
    let s = "My name is omar"
    
    XCTAssertNil(s.find(string: "namx"))
    XCTAssertNil(s.find(string: "omxr"))
  }
  
  func testItCanGetTheSubStringFromIndex() {
    let s = "My name is omar"
    
    XCTAssertEqual(s[from: 3], "name is omar")
    XCTAssertEqual(s[from: 0], "My name is omar")
    XCTAssertEqual(s[from: 7], " is omar")
  }
  
  func testItCanGetTheSubStringToIndex() {
    let s = "My name is omar"
    
    XCTAssertEqual(s[to: 3], "My ")
    XCTAssertEqual(s[to: 1], "M")
    XCTAssertEqual(s[to: 6], "My nam")
  }
  
  func testItCanGetAStringWithRange() {
    let s = "My name is omar"
    
    XCTAssertEqual(s[with: 3..<6], "nam")
    XCTAssertEqual(s[with: 1..<9], "y name i")
    XCTAssertEqual(s[with: 6..<7], "e")
  }
  
}
