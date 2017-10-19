//
//  GridItem.swift
//  Q42Grid
//
//  Created by Shaun Rowe on 13/10/2017.
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import UIKit

struct GridItem {
    
    var number: Int? = nil
    var updated = false
    var fibonnaci = false
    
    init(_ number: Int? = nil) {
        self.number = number
    }
    
}
