//
//  ModelTests.swift
//  GameOfLife
//
//  Created by Kerekes Jozsef-Marton on 05/10/16.
//  Copyright © 2016 mkerekes. All rights reserved.
//

import XCTest

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCell() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
   
        var cell = Cell()
        
        XCTAssertFalse(cell.isAlive())
        
        XCTAssertTrue(cell.bringToLife())
        
        XCTAssertFalse(cell.kill())
        
    }
    
    func testGrid() {
        
        var grid = Grid(size: 6)
        
        var cell = grid.cellAtIndex(row: 0, section: 0)
        
        grid.updateCellAtIndex(row: 0, section: 0, state: cell.bringToLife())
        
        // fetch cell again, should be alive.
        let cell2 = grid.cellAtIndex(row: 0, section: 0)
        
        XCTAssertTrue(cell2.isAlive())
        
        grid.toggleCellAtIndex(row: 0, section: 0)
        
        let cell3 = grid.cellAtIndex(row: 0, section: 0)
                
        XCTAssertFalse(cell3.isAlive())
    }
    
}
