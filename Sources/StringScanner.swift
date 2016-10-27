//
//  StringScanner.swift
//  cli
//
//  Created by Omar Abdelhafith on 25/10/2016.
//
//



/// String Scanner Implementation, similar to NSScanner
/// This class holds an internal index integer that gets advanced as the string is scanned
public class StringScanner {
  
  private let string: String
  private var index: Int
  
  private var stringLength: Int {
    return string.lengthOfBytes(using: .utf8)
  }
  
  private var stringIndex: String.Index {
    return string.index(string.startIndex, offsetBy: index)
  }
  
  
  /// Returns the remaining string
  public var remainingString: String {
    return string.substring(from: stringIndex)
  }
  
  
  /// Initialize a StringScanner
  ///
  /// - parameter string: The string to scan
  ///
  /// - returns:  a new StringScanner
  init(string: String) {
    self.string = string
    self.index = 0
  }
  
  // FIXME: Cross compile PCRE as posix regex does not have non greedy regex
  
  
  /// Peek for a string length
  /// Peek does not advance the internal string index
  ///
  /// - parameter length: the length to return
  ///
  /// - returns: returns a scanner result
  public func peek(length: Int) -> ScannerResult {
    if index >= stringLength {
      return .end
    }
    
    let end = endIndex(forString: string, length: index + length)
    
    let subString = string.substring(with: stringIndex..<end)
    
    return .value(subString)
  }
  
  
  /// Peek until a pattern is found
  /// Peek does not advance the internal string index
  ///
  /// - parameter pattern: a regex pattern
  ///
  /// - returns: returns a scanner result
  public func peek(untilPattern pattern: String) -> ScannerResult {
    return _peek(untilPattern: pattern).0
  }
  
  
  /// Peek until a string is found
  /// Peek does not advance the internal string index
  ///
  /// - parameter search: the string to search
  ///
  /// - returns: returns a scanner result
  public func peek(untilString search: String) -> ScannerResult {
    return _peek(untilString: search).0
  }
  
  
  /// Peek until for a particular string
  /// Peek does not advance the internal string index
  ///
  /// - parameter search: the string to search
  ///
  /// - returns: returns a scanner result
  public func peek(forString search: String) -> ScannerResult {
    return _peek(forString: search).0
  }
  
  
  /// Peek until a range of chacaters is found
  /// Peek does not advance the internal string index
  /// See `CharacterSet` for ready made range of characters
  ///
  /// - parameter range: the range to search
  ///
  /// - returns: returns a scanner result
  public func peek(untilRange range: Containable) -> ScannerResult {
      return _peek(untilRange: range).0
  }
  
  
  /// Peek until a range of chacaters is found, return the character found too
  /// Peek does not advance the internal string index
  /// See `CharacterSet` for ready made range of characters
  ///
  /// - parameter range: the range to search
  ///
  /// - returns: returns a scanner result
  public func peek(forRange range: Containable) -> ScannerResult {
      return _peek(untilRange: range, includeLast: true).0
  }
  
  
  /// Scan for a string length
  /// Scan advances the internal string index
  ///
  /// - parameter length: the length to scan
  ///
  /// - returns: returns a scanner result
  public func scan(length: Int) -> ScannerResult {
    return peek(length: length).performIfValue {
      index += length
    }
  }
  
  
  /// Scan until a string is found
  /// Scan advances the internal string index
  ///
  /// - parameter search: the string to search
  ///
  /// - returns: returns a scanner result
  public func scan(untilString search: String) -> ScannerResult {
    let res = _peek(untilString: search)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  
  /// Scan until a regex pattern is found
  /// Scan advances the internal string index
  ///
  /// - parameter search: the regex pattern to search
  ///
  /// - returns: returns a scanner result
  public func scan(untilPattern pattern: String) -> ScannerResult {
    let res = _peek(untilPattern: pattern)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  
  /// Scan for a string
  /// Scan advances the internal string index
  ///
  /// - parameter search: the string to search
  ///
  /// - returns: returns a scanner result
  public func scan(forString search: String) -> ScannerResult {
    let res = _peek(forString: search)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  
  /// Scan until a characters of string is found
  /// Scan advances the internal string index
  /// See `CharacterSet` for ready made range of characters
  ///
  /// - parameter range: the range to search
  ///
  /// - returns: returns a scanner result
  public func scan(untilRange range: Containable) -> ScannerResult {
      let res = _peek(untilRange: range)
      
      return res.0.performIfValue {
        index = res.1!
      }
  }
  
  
  /// Scan until a characters of string is found, , return the character found too
  /// Scan advances the internal string index
  /// See `CharacterSet` for ready made range of characters
  ///
  /// - parameter range: the range to search
  ///
  /// - returns: returns a scanner result
  public func scan(forRange range: Containable) -> ScannerResult {
      let res = _peek(untilRange: range, includeLast: true)
      
      return res.0.performIfValue {
        index = res.1!
      }
  }
  
  
  /// Drop a certain amount of characters
  /// drop advances the internal string index
  ///
  /// - parameter length: the character lenght to drop
  ///
  /// - returns: bool if there were enough characters in the string, otherwise returns false
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
