//
//  StringScanner.swift
//  cli
//
//  Created by Omar Abdelhafith on 25/10/2016.
//
//


public class StringScanner {
  
  private let string: String
  private var index: Int
  
  private var stringLength: Int {
    return string.lengthOfBytes(using: .utf8)
  }
  
  private var stringIndex: String.Index {
    return string.index(string.startIndex, offsetBy: index)
  }
  
  private var remainingString: String {
    return string.substring(from: stringIndex)
  }
  
  
  init(string: String) {
    self.string = string
    self.index = 0
  }
  
  // FIXME: Cross compile PCRE as posix regex does not have non greedy regex
  
  public func peek(untilPattern pattern: String) -> ScannerResult {
    return _peek(untilPattern: pattern).0
  }
  
  public func peek(untilString search: String) -> ScannerResult {
    return _peek(untilString: search).0
  }
  
  public func peek(forString search: String) -> ScannerResult {
    return _peek(forString: search).0
  }
  
  public func peek(length: Int) -> ScannerResult {
    if index >= stringLength {
      return .end
    }
    
    let end = endIndex(forString: string, length: index + length)
    
    let subString = string.substring(with: stringIndex..<end)
    
    return .value(subString)
  }
  
  public func peek(untilRange range: Containable) -> ScannerResult {
      return _peek(untilRange: range).0
  }
  
  public func peek(forRange range: Containable) -> ScannerResult {
      return _peek(untilRange: range, includeLast: true).0
  }
  
  public func scan(length: Int) -> ScannerResult {
    return peek(length: length).performIfValue {
      index += length
    }
  }
  
  public func scan(untilString search: String) -> ScannerResult {
    let res = _peek(untilString: search)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  public func scan(untilPattern pattern: String) -> ScannerResult {
    let res = _peek(untilPattern: pattern)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  public func scan(forString search: String) -> ScannerResult {
    let res = _peek(forString: search)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  public func scan(untilRange range: Containable) -> ScannerResult {
      let res = _peek(untilRange: range)
      
      return res.0.performIfValue {
        index = res.1!
      }
  }
  
  public func scan(forRange range: Containable) -> ScannerResult {
      let res = _peek(untilRange: range, includeLast: true)
      
      return res.0.performIfValue {
        index = res.1!
      }
  }
  
  public func drop(length: Int) -> Bool {
    if index + length > stringLength {
      index = stringLength
      return false
    }
    
    index += length
    return true
  }
  
  // MARK: Private
  
  private func endIndex(forString string: String, length: Int) -> String.Index {
    if length > stringLength {
      return string.endIndex
    }
    
    return string.index(string.startIndex, offsetBy: length)
  }
  
  private func _peek(untilPattern pattern: String) -> (ScannerResult, Int?) {
    if index >= stringLength {
      return (.end, nil)
    }
    
    let regex = try! Regex(pattern: "(.*)\(pattern)", options: [.extended])
    
    
    let strings = regex.groups(remainingString)
    guard let captured = strings.first else {
      return (.none, nil)
    }
    
    return (.value(captured), captured.lengthOfBytes(using: .utf8))
  }
  
  private func _peek(untilString search: String) -> (ScannerResult, Int?) {
    if index >= stringLength {
      return (.end, nil)
    }
    
    guard let r = remainingString.range(of: search) else {
      return (.none, nil)
    }
    
    let position = remainingString.distance(from: remainingString.startIndex,
                                            to: r.lowerBound)
    let end = endIndex(forString: remainingString, length: position)
    let retString = ScannerResult.value(remainingString.substring(to: end))
    return (retString, position)
  }
  
  private func _peek
    (untilRange: Containable, includeLast: Bool = false) -> (ScannerResult, Int?) {
      
      if index >= stringLength {
        return (.end, nil)
      }
      
      for (index, character) in remainingString.characters.enumerated() {
        if untilRange.contains(character: character) {
          let end = endIndex(forString: remainingString, length: index + (includeLast ? 1 : 0))
          
          let str = remainingString.substring(to: end)
          return (.value(str), index + (includeLast ? 1 : 0))
        }
      }
      
      return (.none, nil)
  }
  
  private func _peek(forString search: String) -> (ScannerResult, Int?) {
    if index >= stringLength {
      return (.end, nil)
    }
    
    
    if remainingString.hasPrefix(search) {
      return (.value(search), index + search.lengthOfBytes(using: .utf8))
    }
    
    return (.none, nil)
  }
  
}
