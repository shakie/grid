//
//  GridService.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import UIKit

class GridService {
    
    func increase(_ gridItems: [[Int]], row: Int, column: Int) -> [[Int]] { //Increase value of items in the row and column
        var items = gridItems
        items[row] = gridItems[row].map { item in item + 1 }
        
        for i in 0..<items.count {
            if i == row { continue }
            items[i][column] = increaseGridItemValue(items[i][column])
        }
        
        return items
    }
    
    func paths(_ row: Int, _ column: Int) -> [IndexPath] { //Convenience method to build an array of IndexPaths
        var section = [IndexPath]()
        var columns = [IndexPath]()
        for i in 0...49 {
            section.append(IndexPath(item: i, section: row))
            columns.append(IndexPath(item: column, section: i))
        }
        
        section.append(contentsOf: columns)
        return section
    }
    
    func fibonacciPaths(_ items: [[Int]]) -> [IndexPath] { //Get IndexPaths for cells containing a fibonacci sequence
        var section = [IndexPath]()
        var columns = [IndexPath]()
        for i in 0..<items.count {
            let fibs = findFibonaccis(items[i])
            if fibs.count > 0 {
                section.append(contentsOf: fibs.flatMap{ $0.map { IndexPath(item: $0, section: i) } })
            }
        }
        
        for i in 0...49 { //Rearrange the array to find sequences in columns
            var flipped = [Int]()
            for x in 0...49 {
                flipped.append(items[x][i])
            }
            let fibs = findFibonaccis(flipped)
            if fibs.count > 0 {
                columns.append(contentsOf: fibs.flatMap{ $0.map { IndexPath(item: i, section: $0) } })
            }
        }
        
        section.append(contentsOf: columns)
        return section
    }
    
    func findFibonaccis(_ items: [Int]) -> [[Int]] {
        let fibonaccis = Array(AnySequence{FibIterator()}.lazy.prefix(60)) //Limiting to the first 60 numbers of the Fibonacci sequence
        var found = [[Int]](repeating: [Int](repeating: 0, count: 0), count: 0)
        
        var i = 0
        while i < items.count - 5 {
            let range = Array(items[i..<i+5]) //Get range from array
            if fibonaccis.contains(subarray: range) { //Does this range contain a sequence of fibonacci numbers
                found.append(Array(i...i+4))
                i += 5 //Move forward to next available start index
            } else {
                i += 1
            }
        }
        
        return found
    }
    
    func resetItemsForIndexPaths(_ gridItems: [[Int]], paths: [IndexPath]) -> [[Int]] { //Reset items to zero
        var items = gridItems
        for path in paths {
            items[path.section][path.item] = 0
        }
        
        return items
    }
    
    private func increaseGridItemValue(_ item: Int) -> Int {
        return item + 1
    }
    
}
