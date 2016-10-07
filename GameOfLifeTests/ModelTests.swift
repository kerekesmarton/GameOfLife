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
        
        _ = cell.bringToLife()
        grid.updateCellAtIndex(row: 0, section: 0, cell)
        
        // fetch cell again, should be alive.
        let cell2 = grid.cellAtIndex(row: 0, section: 0)
        
        XCTAssertTrue(cell2.isAlive())
        
        _ = grid.toggleCellAtIndex(row: 0, section: 0)
        
        let cell3 = grid.cellAtIndex(row: 0, section: 0)
                
        XCTAssertFalse(cell3.isAlive())
    }
    
    func testProgression() {
        
        var grid = Grid(size: 5)
        
        grid.markProgression(row: 0, section: 0)
        XCTAssertTrue(grid.cellAtIndex(row: 0, section: 0).isAlive())
        
        grid.markProgression(row: 0, section: 1)
        XCTAssertTrue(grid.cellAtIndex(row: 0, section: 1).isAlive())
        
        grid.markProgression(row: 1, section: 0)
        XCTAssertTrue(grid.cellAtIndex(row: 1, section: 0).isAlive())
        
        grid.markProgression(row: 1, section: 2)
        XCTAssertTrue(grid.cellAtIndex(row: 1, section: 0).isAlive())
        
        // The given rules should turn this cell on.
        XCTAssertTrue(grid.cellAtIndex(row: 1, section: 1).isAlive())
    }
    
    func testNeightbours() {
        
        let grid = Grid(size: 3)
        var neightbourArray = grid.neighbours(row: 1, section: 1)
        
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 0, section: 0)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 0, section: 1)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 0, section: 2)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 1, section: 0)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 1, section: 2)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 2, section: 0)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 2, section: 1)])
        XCTAssertNotNil(neightbourArray[IndexPath.init(row: 2, section: 2)])
        
        XCTAssertNil(neightbourArray[IndexPath.init(row: 1, section: 1)])
        
        
    }
    
}
