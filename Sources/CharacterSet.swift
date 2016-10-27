//
//  CharacterSets.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 26/10/2016.
//
//

/// Range Set
public enum CharacterSet: Containable {
  
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
  
  /// Characters in the string
  case string(String)
  
  /// Containable Array
  case containables([Containable])
  
  /// Range (and closed range)
  case range(Containable)
  
  /// Join with another containable
  public func join(characterSet: CharacterSet) -> CharacterSet {
    let array = [characterSet.containable, self.containable]
    return .containables(array)
  }
  
  public func contains(character element: Character) -> Bool {
    return self.containable.contains(character: element)
  }
  
  var containable: Containable {
    
    switch self {
    case .smallLetters:
      return RangeContainable(ranges: "a"..."z")
    case .capitalLetters:
      return RangeContainable(ranges: "A"..."Z")
    case .allLetters:
      return RangeContainable(
        ranges: CharacterSet.smallLetters.containable, CharacterSet.capitalLetters.containable)
    case .numbers:
      return RangeContainable(ranges: "0"..."9")
    case .space:
      return RangeContainable(ranges: " "..." ")
    case .alphaNumeric:
      return RangeContainable(ranges:
        CharacterSet.allLetters.containable, CharacterSet.numbers.containable)
    case .string(let string):
      return ContainableString(stringOfCharacters: string)
    case .containables(let array):
      return RangeContainable(array: array)
    case .range(let range):
      return RangeContainable(ranges: range)
    }
  }
}


private struct ContainableString: Containable {
  let stringOfCharacters: String
  
  func contains(character element: Character) -> Bool {
    return stringOfCharacters.contains(String(element))
  }
}


private struct RangeContainable: Containable {
  let ranges: [Containable]
  
  init(ranges: Containable...) {
    self.ranges = ranges
  }
  
  init(array: [Containable]) {
    self.ranges = array
  }
  
  func contains(character element: Character) -> Bool {
    let filtered = ranges.filter { $0.contains(character: element) }
    return filtered.count > 0
  }
}
