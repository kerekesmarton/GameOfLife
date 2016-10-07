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
    private var liveNeighbours: Int = 0
    func isAlive() -> Bool {
        return live
    }
    
    init() {
        self.live = false
    }
    
    init(_ live: Bool, _ liveNeighbours: Int) {
        
        self.live = live
        self.liveNeighbours = liveNeighbours
    }

    mutating func kill() -> Bool {
        
        live = false
        return live
    }
    
    mutating func bringToLife() -> Bool {
        
        live = true
        return live
    }
    
    mutating func naturalProgressionByAddingLive() {
        
        liveNeighbours += 1
        
        switch liveNeighbours {
        case 3...8:
            _ = bringToLife()
        default:
            ()
        }
    }
    
    mutating func naturalProgressionByRemoveLive() {
        
        liveNeighbours -=  1
        switch liveNeighbours {
        case 0...1:
            _ = kill()
        default:
            ()
        }
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
    
    mutating func updateCellAtIndex(row: Int, section: Int, _ cell: Cell) -> Void {
        
        cells[row][section] = cell
    }
    
    mutating func toggleCellAtIndex(row: Int, section: Int) -> Cell {
        
        var cell = cellAtIndex(row: row, section: section)
        _ = cell.isAlive() ? cell.kill() : cell.bringToLife()
        updateCellAtIndex(row: row, section: section, cell)
        
        return cell
    }
    
    mutating func markProgression(row: Int, section: Int) -> Void {
        
        let cell = toggleCellAtIndex(row: row, section: section)
        
        _ = neighbours(row:row,section:section).flatMap { (index: IndexPath, neighbourCell: Cell) in
            
            var newCell = neighbourCell
            if cell.isAlive() {
                newCell.naturalProgressionByAddingLive()
            } else {
                newCell.naturalProgressionByRemoveLive()
            }
            updateCellAtIndex(row: index.row, section: index.section, newCell)
        }        
    }
    
    func neighbours(row: Int, section: Int) -> Dictionary<IndexPath,Cell> {
        
        var results:Dictionary<IndexPath,Cell> = Dictionary()
        
        for i in row-1...row+1 {
        
            if i >= 0 && i <= cells.count-1 {
                
                let rowCells = cells[i]
                
                for j in section-1...section+1 {
                    
                    if j >= 0 && j <= rowCells.count-1 {
                        
                        if !(i == row && j == section) {
                            let ip = IndexPath.init(row: i, section: j)
                            results[ip] = rowCells[j]
                        }
                    }
                }
            }
        }
        
        return results
    }
}
