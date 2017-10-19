//
//  Q42GridSpec.swift
//  Q42GridTests
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Q42Grid

class GridServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("Given a GridService") {
            
            let service = GridService()
            var items: [[Int]]!
            
            beforeEach {
                items = [[Int]](repeating: [Int](repeating: 0, count: 50), count: 50)
            }
            
            context("When a fibonacci sequence exists in a row") {
                
                beforeEach {
                    items[0][0] = 1
                    items[0][1] = 1
                    items[0][2] = 2
                    items[0][3] = 3
                    items[0][4] = 5
                    
                    items[0][11] = 5
                    items[0][12] = 5
                    items[0][13] = 8
                    items[0][14] = 13
                    items[0][15] = 21
                    items[0][16] = 34
                    
                    items[2][2] = 8
                    items[3][2] = 13
                    items[4][2] = 21
                    items[5][2] = 34
                    items[6][2] = 55
                }
                
                it("Then the array of indices of the elements is returned") {
                    let fibonaccis = service.findFibonaccis(items[0])
                    expect(fibonaccis.count).to(equal(2))
                    expect(fibonaccis[0].count).to(equal(5))
                    expect(fibonaccis[0][0]).to(equal(0))
                    expect(fibonaccis[0][1]).to(equal(1))
                    expect(fibonaccis[0][2]).to(equal(2))
                    expect(fibonaccis[0][3]).to(equal(3))
                    expect(fibonaccis[0][4]).to(equal(4))
                    
                    expect(fibonaccis[1].count).to(equal(5))
                    expect(fibonaccis[1][0]).to(equal(12))
                    expect(fibonaccis[1][1]).to(equal(13))
                    expect(fibonaccis[1][2]).to(equal(14))
                    expect(fibonaccis[1][3]).to(equal(15))
                    expect(fibonaccis[1][4]).to(equal(16))
                }
                
                it("Then the IndexPath array for the sequences is returned") {
                    let fibonaccis = service.fibonacciPaths(items)
                    expect(fibonaccis[0]).to(beAKindOf(IndexPath.self))
                    expect(fibonaccis.count).to(equal(15))
                    
                    expect(fibonaccis[0].section).to(equal(0))
                    expect(fibonaccis[0].item).to(equal(0))
                    expect(fibonaccis[1].section).to(equal(0))
                    expect(fibonaccis[1].item).to(equal(1))
                    expect(fibonaccis[2].section).to(equal(0))
                    expect(fibonaccis[2].item).to(equal(2))
                    expect(fibonaccis[3].section).to(equal(0))
                    expect(fibonaccis[3].item).to(equal(3))
                    expect(fibonaccis[4].section).to(equal(0))
                    expect(fibonaccis[4].item).to(equal(4))
                    
                    expect(fibonaccis[5].section).to(equal(0))
                    expect(fibonaccis[5].item).to(equal(12))
                    expect(fibonaccis[6].section).to(equal(0))
                    expect(fibonaccis[6].item).to(equal(13))
                    expect(fibonaccis[7].section).to(equal(0))
                    expect(fibonaccis[7].item).to(equal(14))
                    expect(fibonaccis[8].section).to(equal(0))
                    expect(fibonaccis[8].item).to(equal(15))
                    expect(fibonaccis[9].section).to(equal(0))
                    expect(fibonaccis[9].item).to(equal(16))
                    
                    expect(fibonaccis[10].section).to(equal(2))
                    expect(fibonaccis[10].item).to(equal(2))
                    expect(fibonaccis[11].section).to(equal(3))
                    expect(fibonaccis[11].item).to(equal(2))
                    expect(fibonaccis[12].section).to(equal(4))
                    expect(fibonaccis[12].item).to(equal(2))
                    expect(fibonaccis[13].section).to(equal(5))
                    expect(fibonaccis[13].item).to(equal(2))
                    expect(fibonaccis[14].section).to(equal(6))
                    expect(fibonaccis[14].item).to(equal(2))
                }
                
                it("Then the items can be reset at the corresponding IndexPaths") {
                    let fibonaccis = service.fibonacciPaths(items)
                    var reset = service.resetItemsForIndexPaths(items, paths: fibonaccis)
                    
                    expect(reset[0][0]).to(equal(0))
                    expect(reset[0][1]).to(equal(0))
                    expect(reset[0][2]).to(equal(0))
                    expect(reset[0][3]).to(equal(0))
                    expect(reset[0][4]).to(equal(0))
                    
                    expect(reset[0][12]).to(equal(0))
                    expect(reset[0][13]).to(equal(0))
                    expect(reset[0][14]).to(equal(0))
                    expect(reset[0][15]).to(equal(0))
                    expect(reset[0][16]).to(equal(0))
                }
                
            }
            
            context("When a column and row is selected") {
                
                it("Then the value in that column or row is increased by 1") {
                    var updated = service.increase(items, row: 3, column: 2)
                    expect(updated[3][0]).to(equal(1))
                    expect(updated[3][1]).to(equal(1))
                    expect(updated[3][2]).to(equal(1))
                    expect(updated[4][2]).to(equal(1))
                    expect(updated[4][1]).to(equal(0))
                }
                
                it("Then the IndexPath array for the updated items is returned") {
                    var paths = service.paths(3, 2)
                    
                    expect(paths[0]).to(beAKindOf(IndexPath.self))
                    expect(paths[0].section).to(equal(3))
                    expect(paths[0].item).to(equal(0))
                    expect(paths[1].section).to(equal(3))
                    expect(paths[1].item).to(equal(1))
                    expect(paths[50].section).to(equal(0))
                    expect(paths[50].item).to(equal(2))
                }
                
            }
            
        }
        
    }
    
}
