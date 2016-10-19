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

    mutating func kill() {
        
        live = false
    }
    
    mutating func bringToLife() {
        
        live = true
    }
    
    /*
     
     
     
     
     */
    
    mutating func naturalProgression(_ totalLive : UInt){
        
        switch totalLive {
        case 0...1:
            // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
            if isAlive() {
                kill()
            }
        case 2...3:
            
            if isAlive() {
                // Any live cell with two or three live neighbours lives on to the next generation.
            } else {
                if totalLive == 3 {
                    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                    bringToLife()
                }
            }
        case 4...UInt.max:
            // Any live cell with more than three live neighbours dies, as if by over-population.
            if isAlive() {
                kill()
            }
        default: break
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
    
    mutating func toggleCellAtIndex(row: Int, section: Int) {
        
        var cell = cellAtIndex(row: row, section: section)
        if cell.isAlive() {
            _ = cell.kill()
        } else {
            _ = cell.bringToLife()
        }
        updateCellAtIndex(row: row, section: section, cell)
    }
    
    mutating func markProgression(row: Int, section: Int) -> Void {
        
        print(section, row)
        toggleCellAtIndex(row: row, section: section)
        
        for (index, neighbourCell) in neighbours(row:row,section:section) {
            
            let liveCount = countForIndex(index)
            var newCell = neighbourCell
            
            newCell.naturalProgression(liveCount)
            updateCellAtIndex(row: index.row, section: index.section, newCell)
        }
    }
    
    func countForIndex(_ index: IndexPath) -> UInt {
        var liveCount : UInt = 0
        for (_,secondNeighbour) in neighbours(row: index.row, section: index.section) {
            
            liveCount += secondNeighbour.isAlive() ? 1 : 0
        }
        
        return liveCount
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
