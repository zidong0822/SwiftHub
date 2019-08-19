//
//  SettingsViewController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
private let reuseIdentifier = R.reuseIdentifier.settingCell.identifier
class SettingsViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func makeUI() {
        super.makeUI()
        
//        languageChanged.subscribe(onNext: { [weak self] () in
//         self?.navigationTitle = R.string.localizable.settingsNavigationTitle.key.localized()
//        }).disposed(by: rx.disposeBag)
//
//        tableView.register(R.nib.settingCell)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
//        guard let viewModel = viewModel as? SettingsViewModel else { return }
//
//        let refresh = Observable.of(rx.viewWillAppear.mapToVoid(), languageChanged.asObservable()).merge()
//        let input = SettingsViewModel.Input(trigger: refresh,
//                                            selection: tableView.rx.modelSelected(SettingsSectionItem.self).asDriver())
//        let output = viewModel.transform(input: input)
//        let dataSource = RxTableViewSectionedReloadDataSource<SettingsSection>(configureCell: { dataSource, tableView, indexPath, item in
//            switch item {
//            case .profileItem(let viewModel):
//                let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingCell)!
//                cell.bind(to:viewModel)
//                return cell
//            }
//        },titleForHeaderInSection: { dataSource,index in
//            let section = dataSource[index]
//            return section.title
//        })
//        output.items.asObservable().bind(to:tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}
