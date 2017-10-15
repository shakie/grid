//
//  GridViewModel.swift
//  Q42Grid
//
//  Created by Shaun Rowe on 13/10/2017.
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation

struct GridViewModel {
    
    let service = GridService()
    let items = [[GridItem]](repeating: [GridItem](repeating: GridItem(), count: 50), count: 50)
    
    init() {
        
    }
    
}
