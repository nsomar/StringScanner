//
//  ScannerResult.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 26/10/2016.
//
//

/// Scanner Result represents a result retured from the string scanner
///
/// - value: A vaule was found
/// - none:  No value was found,
///   this is used when peeking or scanning until a string or regex pattern
///   if the pattern is not found, .none is retured
/// - end:   We reached the end of the string
public enum ScannerResult {
  case value(String)
  case none
  case end
  
  func performIfValue(block: (() -> ())) -> ScannerResult {
    if case .value = self {
      block()
    }
    
    return self
  }
}


/// Contailable protocol
public protocol Containable {
  
  
  /// Returns wether a character is inside the range or not
  ///
  /// - parameter element: the character to search
  ///
  /// - returns: true if its inside, otherwise false
  func contains(character element: Character) -> Bool
}


extension Range: Containable {
  public func contains(character element: Character) -> Bool {
    guard let element = String(element) as? Bound else {
      return false
    }
    
    return self.contains(element)
  }
}

extension ClosedRange: Containable {
  public func contains(character element: Character) -> Bool {
    guard let element = String(element) as? Bound else {
      return false
    }
    
    return self.contains(element)
  }
}
