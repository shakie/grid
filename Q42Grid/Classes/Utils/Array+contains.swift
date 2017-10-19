//
//  Array+contains.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func contains(subarray: [Element]) -> Bool {
        var found = 0
        for element in self where found < subarray.count {
            if element == subarray[found] {
                found += 1
            } else {
                found = element == subarray[0] ? 1 : 0
            }
        }
        
        return found == subarray.count
    }
}
