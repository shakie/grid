//
//  GridViewController.swift
//  Q42Grid
//
//  Created by Shaun Rowe on 12/10/2017.
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 50,
        minimumInteritemSpacing: 2,
        minimumLineSpacing: 2,
        sectionInset: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.collectionViewLayout = columnLayout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2499
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath)
    }
    
}

