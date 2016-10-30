//
//  StringExtension.swift
//  StringScanner
//
//  Created by Omar Abdelhafith on 30/10/2016.
//
//

extension String {
  
  func find(string: String) -> String.Index? {
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
            offsetBy: -string.characters.count)
        }
      } else {
        currentIndex = self.index(after: currentIndex)
        
        if searchIndex != string.startIndex {
          searchIndex = string.startIndex
        }
      }
    }
  }
  
  subscript(from index: String.Index) -> String {
    return String(self.characters[index..<self.endIndex])
  }
  
  subscript(from index: Int) -> String {
    let start = self.index(self.startIndex, offsetBy: index)
    return self[from: start]
  }
  
  subscript(to index: String.Index) -> String {
    return String(self.characters[self.startIndex..<index])
  }
  
  subscript(to index: Int) -> String {
    let end = self.index(self.startIndex, offsetBy: index)
    return self[to: end]
  }
  
  subscript(with ranage: Range<String.Index>) -> String {
    return String(self.characters[ranage])
  }
  
  subscript(with index: Range<Int>) -> String {
    let start = self.index(self.startIndex, offsetBy: index.lowerBound)
    let end = self.index(self.startIndex, offsetBy: index.upperBound)
    return self[with: start..<end]
  }
}
