//
//  GridItemViewModel.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import RxSwift

struct GridItemViewModel {
    
    let number = Variable<String>("")
    
    func update(_ item: Int) {
        self.number.value = item > 0 ? "\(item)" : ""
    }
    
}
