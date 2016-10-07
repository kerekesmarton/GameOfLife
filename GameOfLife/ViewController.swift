//
//  ViewController.swift
//  GameOfLife
//
//  Created by Kerekes Jozsef-Marton on 05/10/16.
//  Copyright © 2016 mkerekes. All rights reserved.
//

import UIKit
import CoreGraphics

let SIZE = 5


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var grid = Grid(size:SIZE)
    var cellSize: Double = 0.0
    
    @IBOutlet var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.frame = UIScreen.main.bounds
        let screenWidth = collectionView?.frame.size.width
        cellSize = floor(Double(screenWidth!) / Double(SIZE))
        
        collectionView?.backgroundColor = UIColor.green
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return grid.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let row = grid.cells[section]
        return row.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cvCell : CollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! CollectionViewCell
        let gameCell = grid.cellAtIndex(row: indexPath.row, section: indexPath.section)
        cvCell.indicator.backgroundColor = gameCell.isAlive() ? UIColor.red : UIColor.blue
        
        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        grid.toggleCellAtIndex(row: indexPath.row, section: indexPath.section)
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: cellSize, height: cellSize)
    }
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var indicator: UIView!
}
