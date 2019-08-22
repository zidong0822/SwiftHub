//
//  LanguageViewController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/22.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import Rswift
import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = R.reuseIdentifier.languageCell.identifier

class LanguageViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.languagesNavigationTitle.key.localized()
        }).disposed(by: rx.disposeBag)
        
        tableView.register(R.nib.languageCell)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? LanguageViewModel else { return }
        
        let refresh = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        let input = LanguageViewModel.Input(trigger: refresh,
                                            selection: tableView.rx.modelSelected(LanguageCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
     
        output.items
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: LanguageCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)

    }
}
