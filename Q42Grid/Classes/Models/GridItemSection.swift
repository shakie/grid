//
//  GridItemSection.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import RxDataSources

struct GridItemSection {
    var items: [Item]    
}

extension GridItemSection: SectionModelType {
    typealias Item = Int
    
    init(original: GridItemSection, items: [Item]) {
        self = original
        self.items = items
    }
    
}
