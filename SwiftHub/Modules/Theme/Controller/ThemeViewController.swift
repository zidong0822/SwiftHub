//
//  ThemeViewController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/21.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = R.reuseIdentifier.themeCell.identifier

class ThemeViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func makeUI() {
        super.makeUI()
        navigationTitle = R.string.localizable.themeNavigationTitle.key.localized()
        tableView.register(R.nib.themeCell)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? ThemeViewModel else { return }
        
        let input = ThemeViewModel.Input(refresh: Observable.just(()),
                                         selection: tableView.rx.modelSelected(ThemeCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: ThemeCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)
        
//        output.selected.drive(onNext: { [weak self] (cellViewModel) in
//            self?.navigator.dismiss(sender: self)
//        }).disposed(by: rx.disposeBag)
    }

}
