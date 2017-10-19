//
//  GridViewController.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class GridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposables = DisposeBag()
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 50,
        minimumInteritemSpacing: 1,
        minimumLineSpacing: 1,
        sectionInset: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    )
    let viewModel = GridViewModel()
    let dataSource = RxCollectionViewSectionedReloadDataSource<GridItemSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.collectionViewLayout = columnLayout
        setupDataSource()
        setupObservables()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - Rx
extension GridViewController {
    
    func setupDataSource() { //Configure the cell for the dataSource
        dataSource.configureCell = { (ds: CollectionViewSectionedDataSource<GridItemSection>, cv: UICollectionView, indexPath: IndexPath, item: GridItemSection.Item) in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
            cell.viewModel.update(item)
            return cell
        }
    }
    
    fileprivate func setupObservables() { //Setup our Rx observables
        setupCellFlashers()
        
        viewModel.dataSource.asObservable().observeOn(MainScheduler.instance) //Observe changes to the dataSource on the ViewModel
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposables)
        
        collectionView.rx.itemSelected.observeOn(MainScheduler.instance) //Action to take when cell is selected
            .subscribe(onNext: { [unowned self] indexPath in
                self.viewModel.increaseRowAndColumn(indexPath.section, indexPath.item)
            }).disposed(by: disposables)
    }
    
    private func setupCellFlashers() {
        viewModel.flashCells.asObservable().observeOn(MainScheduler.instance) //Observe changes to the flashCells
            .subscribe(onNext: { [unowned self] paths in
                guard let paths = paths else { return }
                for path in paths {
                    if let cell = self.collectionView.cellForItem(at: path) as? GridCollectionViewCell {
                        cell.updatedBackgroundFlash()
                    }
                }
            }).disposed(by: disposables)
        
        viewModel.fibonacciCells.asObservable().observeOn(MainScheduler.instance) //Observe changes to the fibonacci cells
            .subscribe(onNext: { [unowned self] paths in
                guard let paths = paths else { return }
                for path in paths {
                    if let cell = self.collectionView.cellForItem(at: path) as? GridCollectionViewCell {
                        cell.fibonacciBackgroundFlash()
                    }
                }
            }).disposed(by: disposables)
    }
    
}
