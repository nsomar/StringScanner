//
//  RangeSets.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 26/10/2016.
//
//

/// Range Set
public enum RangeSet {
  
  /// All english letters set
  case allLetters
  
  /// Small english letters set
  case smallLetters
  
  /// Capital english letters set
  case capitalLetters
  
  /// Numbers set
  case numbers
  
  /// Spaces set
  case space
  
  /// Alpha Numeric set
  case alphaNumeric
  
  var containable: Containable {
    
    switch self {
    case .smallLetters:
      return StringContainable(ranges: "a"..."z")
    case .capitalLetters:
      return StringContainable(ranges: "A"..."Z")
    case .allLetters:
      return StringContainable(
        ranges: RangeSet.smallLetters.containable, RangeSet.capitalLetters.containable)
    case .numbers:
      return StringContainable(ranges: "0"..."9")
    case .space:
      return StringContainable(ranges: " "..." ")
    case .alphaNumeric:
      return StringContainable(ranges:
        RangeSet.allLetters.containable, RangeSet.numbers.containable)
    }
  }
}

private struct StringContainable: Containable {
  let ranges: [Containable]
  
  init(ranges: Containable...) {
    self.ranges = ranges
  }
  
  func contains(character element: Character) -> Bool {
    let filtered = ranges.filter { $0.contains(character: element) }
    return filtered.count > 0
  }
}
