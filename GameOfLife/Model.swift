//
//  Model.swift
//  GameOfLife
//
//  Created by Kerekes Jozsef-Marton on 05/10/16.
//  Copyright © 2016 mkerekes. All rights reserved.
//

import Foundation

struct Cell {
    
    private var live : Bool = false
    
    func isAlive() -> Bool {
        return live
    }
    
    init() {
        self.live = false
    }
    
    init(_ live: Bool) {
        
        self.live = live
    }

    mutating func kill() -> Bool {
        
        live = false
        return live
    }
    
    mutating func bringToLife() -> Bool {
        
        live = true
        return live
    }
}

struct Grid {
    
    var cells : Array<Array<Cell>>
    
    init(size: Int) {
        
        cells = Array()
        for _ in 0...size-1 {
            
            var row : Array<Cell> = Array()
            for _ in 0...size-1 {
                
                row.append(Cell())
            }
            cells.append(row)
        }
    }
    
    func cellAtIndex(row: Int, section: Int) -> Cell {
        
        return cells[row][section]
    }
    
    mutating func updateCellAtIndex(row: Int, section: Int, state: Bool) -> Void {
        
        cells[row][section] = Cell(state)
    }
    
    mutating func toggleCellAtIndex(row: Int, section: Int) -> Void {
        
        let cell = cellAtIndex(row: row, section: section)
        updateCellAtIndex(row: row, section: section, state: !cell.isAlive())
    }
    
    mutating func markProgression(row: Int, section: Int) -> Void {
        
        
    }
}
