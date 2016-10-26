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

public protocol Containable {
  func contains(string element: String) -> Bool
}

extension Range: Containable {
  public func contains(string element: String) -> Bool {
    guard let x = self as? Range<String> else {
      return false
    }
    
    return x.contains(element)
  }
}
extension ClosedRange: Containable {
  public func contains(string element: String) -> Bool {
    guard let x = self as? ClosedRange<String> else {
      return false
    }
    
    return x.contains(element)
  }
}
