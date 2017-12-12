//
//  StringExtension.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 30/10/2016.
//
//


// MARK: - Utility string functions, not relying on foundation
extension String {
  
  
  /// Finds a string in the string
  ///
  /// - parameter string: the string to find
  ///
  /// - returns: the index
  public func find(string: String) -> String.Index? {
    var currentIndex = self.startIndex
    var searchIndex = string.startIndex
    
    while true {
      if currentIndex == self.endIndex {
        return nil
      }
      
      if self[currentIndex] == string[searchIndex] {
        currentIndex = self.index(after: currentIndex)
        searchIndex = string.index(after: searchIndex)
        
        if searchIndex == string.endIndex {
          return self.index(
            currentIndex,
            offsetBy: -string.count)
        }
      } else {
        currentIndex = self.index(after: currentIndex)
        
        if searchIndex != string.startIndex {
          searchIndex = string.startIndex
        }
      }
    }
  }
  
  
  /// Checks if the string is prefixed by another string
  ///
  /// - parameter string: string to search
  ///
  /// - returns: true if found
  public func isPrefixed(by string: String) -> Bool {
    var currentIndex = self.startIndex
    var searchIndex = string.startIndex
    
    while true {
      if currentIndex == self.endIndex {
        return false
      }
      
      if self[currentIndex] == string[searchIndex] {
        currentIndex = self.index(after: currentIndex)
        searchIndex = string.index(after: searchIndex)
        
        if searchIndex == string.endIndex {
          return true
        }
      } else {
        return false
      }
    }
  }
  
  
  /// Substring from index
  ///
  /// - parameter index: the index to start
  ///
  /// - returns: the substring
  public subscript(from index: String.Index) -> String {
    return String(self[index..<self.endIndex])
  }
  
  /// Substring from index
  ///
  /// - parameter index: the index to start
  ///
  /// - returns: the substring
  public subscript(from index: Int) -> String {
    let start = self.index(self.startIndex, offsetBy: index)
    return self[from: start]
  }
  
  /// Substring to index
  ///
  /// - parameter index: the index to end
  ///
  /// - returns: the substring
  public subscript(to index: String.Index) -> String {
    return String(self[self.startIndex..<index])
  }
  
  /// Substring to index
  ///
  /// - parameter index: the index to end
  ///
  /// - returns: the substring
  public subscript(to index: Int) -> String {
    let end = self.index(self.startIndex, offsetBy: index)
    return self[to: end]
  }
  
  /// Substring with range
  ///
  /// - parameter range: the range
  ///
  /// - returns: the substring
  public subscript(with ranage: Range<String.Index>) -> String {
    return String(self[ranage])
  }
  
  /// Substring with range
  ///
  /// - parameter range: the range
  ///
  /// - returns: the substring
  public subscript(with range: Range<Int>) -> String {
    let start = self.index(self.startIndex, offsetBy: range.lowerBound)
    let end = self.index(self.startIndex, offsetBy: range.upperBound)
    return self[with: start..<end]
  }
}
