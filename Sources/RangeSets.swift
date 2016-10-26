//
//  RangeSets.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 26/10/2016.
//
//

public enum RangeSet {
  case allLetters
  case smallLetters
  case capitalLetters
  case numbers
  case space
  case alphaNumeric
  
  var containable: Containable {
    
    switch self {
    case .smallLetters:
      return "a"..."z"
    case .capitalLetters:
      return "A"..."Z"
    case .allLetters:
      return ("a"..."z").clamped(to: "A"..."Z")
    case .numbers:
      return ("0"..."9")
    case .space:
      return (" "..." ")
    case .alphaNumeric:
      return ("a"..."z").clamped(to: "a"..."z").clamped(to: "A"..."Z")
    }
  }
}
