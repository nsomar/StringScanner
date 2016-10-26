//
//  StringScanner.swift
//  cli
//
//  Created by Omar Abdelhafith on 25/10/2016.
//
//


enum ScannerResult {
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

class StringScanner {
  
  let string: String
  var index: Int
  
  var stringLength: Int {
    return string.lengthOfBytes(using: .utf8)
  }
  
  var stringIndex: String.Index {
    return string.index(string.startIndex, offsetBy: index)
  }
  
  var remainingString: String {
    return string.substring(from: stringIndex)
  }
  
  init(string: String) {
    self.string = string
    self.index = 0
  }
  
  
  func endIndex(forString string: String, length: Int) -> String.Index {
    if length > stringLength {
      return string.endIndex
    }
    
    return string.index(string.startIndex, offsetBy: length)
  }
  
  // FIXME: Cross compile PCRE as posix regex does not have non greedy regex
  
  func peek(untilPattern pattern: String) -> ScannerResult {
    return _peek(untilPattern: pattern).0
  }
  
  func _peek(untilPattern pattern: String) -> (ScannerResult, Int?) {
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
  
  func peek(untilString search: String) -> ScannerResult {
    return _peek(untilString: search).0
  }
  
  func _peek(untilString search: String) -> (ScannerResult, Int?) {
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
  
  func peek(length: Int) -> ScannerResult {
    if index >= stringLength {
      return .end
    }
    
    let end = endIndex(forString: string, length: index + length)
    
    let subString = string.substring(with: stringIndex..<end)
    
    return .value(subString)
  }
  
  func scan(length: Int) -> ScannerResult {
    return peek(length: length).performIfValue {
      index += length
    }
  }
  
  func scan(untilString search: String) -> ScannerResult {
    let res = _peek(untilString: search)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  func scan(untilPattern pattern: String) -> ScannerResult {
    let res = _peek(untilPattern: pattern)
    
    return res.0.performIfValue {
      index = res.1!
    }
  }
  
  func drop(length: Int) -> Bool {
    if length > stringLength {
      return false
    }
    
    index += length
    return true
  }
  
}
