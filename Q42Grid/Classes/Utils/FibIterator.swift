//
//  FibIterator.swift
//  Q42Grid
//
//  Created by Shaun Rowe on 13/10/2017.
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation

class FibIterator : IteratorProtocol {
    var (a, b) = (1, 0)
    
    func next() -> Int? {
        (a, b) = (b, a + b)
        return a
    }
}
