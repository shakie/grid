//
//  FibIterator.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation

class FibIterator : IteratorProtocol {
    var (a, b) = (0, 1) //Start the sequence at 1 as we have no 0 values in our grid
    
    func next() -> Int? {
        (a, b) = (b, a + b)
        return a
    }
}
