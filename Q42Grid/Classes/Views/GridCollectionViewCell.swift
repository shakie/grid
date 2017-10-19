//
//  GridCollectionViewCell.swift
//  Q42Grid
//
//  Copyright © 2017 Shaun Rowe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelNumber: UILabel!
    
    let disposables = DisposeBag()
    var viewModel = GridItemViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupObservables()
    }
    
    func updatedBackgroundFlash() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.backgroundColor = .yellow
        }) { [weak self] finished in
            UIView.animate(withDuration: 0.5, animations: {
                self?.backgroundColor = .clear
            }, completion: nil)
        }
    }
    
    func fibonacciBackgroundFlash() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.backgroundColor = .green
        }) { [weak self] finished in
            UIView.animate(withDuration: 0.5, animations: {
                self?.backgroundColor = .clear
            }, completion: nil)
        }
    }

    private func setupObservables() {
        viewModel.number.asObservable().observeOn(MainScheduler.instance)
            .bind(to: labelNumber.rx.text) //Bind value of number to the label
            .disposed(by: disposables)
    }
    
}
