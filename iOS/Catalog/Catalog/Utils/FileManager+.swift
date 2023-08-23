//
//  FileManager+.swift
//  Catalog
//
//  Created by Jung peter on 8/22/23.
//

import Foundation

extension FileManager {
  
  func enumerateContentsOfDirectory(atPath path: String,
                                    orderedByProperty property: URLResourceKey = .contentAccessDateKey,
                                    ascending: Bool) -> [URL] {
  
    let directoryURL: URL
    if #available(iOS 16.0, *) {
      directoryURL = URL(filePath: path)
    } else {
      directoryURL = URL(fileURLWithPath: path)
    }
    
    do {
      let contents = try self.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: [URLResourceKey.contentModificationDateKey], options: FileManager.DirectoryEnumerationOptions())
      
      let sortedContents = contents.sorted(by: { (lhs: URL, rhs: URL) -> Bool in
        
        var lhsValue : AnyObject?
        var rhsValue : AnyObject?
        
        do {
          try (lhs as NSURL).getResourceValue(&lhsValue, forKey: URLResourceKey(rawValue: property.rawValue))
        } catch {
            return true
        }
        
        do {
          try (rhs as NSURL).getResourceValue(&rhsValue, forKey: URLResourceKey(rawValue: property.rawValue))
        } catch {
            return false
        }
        
        if let lhsStr = lhsValue as? String, let rhsStr = rhsValue as? String {
          return ascending ? lhsStr < rhsStr : rhsStr < lhsStr
        }
        
        if let lhsData = lhsValue as? Date, let rhsData = rhsValue as? Date {
            return ascending ? lhsData < rhsData : rhsData < lhsData
        }
        
        return false
      })
      
      return sortedContents
      
    } catch {
      
      Log.error(message: FileManagerError.notAvailableOfFetchContentByProperties.localizedDescription, error: error)
      
      return []
    }
    
  }
  
}
