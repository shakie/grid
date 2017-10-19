//
//  GridViewModel.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct GridViewModel {
    
    let disposables = DisposeBag()
    let service = GridService()
    let items = Variable<[[Int]]>([[Int]](repeating: [Int](repeating: 0, count: 50), count: 50))
    let dataSource = Variable<[GridItemSection]>([GridItemSection]())
    let flashCells = Variable<[IndexPath]?>(nil)
    let fibonacciCells = Variable<[IndexPath]?>(nil)
    
    init() {
        setupObservables()
    }
    
    func increaseRowAndColumn(_ row: Int, _ column: Int) {
        items.value = service.increase(items.value, row: row, column: column)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) { //Slight delay for flashing
            self.flashCells.value = self.service.paths(row, column)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) { //Slight delay for detecting fibonaccis
                let paths = self.service.fibonacciPaths(self.items.value)
                if paths.count > 0 {
                    self.fibonacciCells.value = paths
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0){ //Slight delay for clearing items with fibonaccis detected
                        self.items.value = self.service.resetItemsForIndexPaths(self.items.value, paths: paths)
                    }
                }
            }
        }
    }
    
    private func setupObservables() {
        items.asObservable().observeOn(MainScheduler.instance) //Observe changes to the items
            .subscribe(onNext: { gridItems in
                var sectionItems = [GridItemSection]()
                for items in gridItems {
                    sectionItems.append(GridItemSection(items: items))
                }
                self.dataSource.value = sectionItems //Updated the dataSource with the SectionModels
            }).disposed(by: disposables)
    }
    
}
