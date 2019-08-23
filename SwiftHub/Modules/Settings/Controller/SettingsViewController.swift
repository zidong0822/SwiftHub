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
private let switchReuseIdentifier = R.reuseIdentifier.settingSwitchCell.identifier
class SettingsViewController: TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.settingsNavigationTitle.key.localized()
        }).disposed(by: rx.disposeBag)
        
        tableView.register(R.nib.settingCell)
        tableView.register(R.nib.settingSwitchCell)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? SettingsViewModel else { return }
        let input = SettingsViewModel.Input(trigger: rx.viewWillAppear.mapToVoid(),
                                            selection: tableView.rx.modelSelected(SettingsSectionItem.self).asDriver())
        let output = viewModel.transform(input: input)
        let dataSource = RxTableViewSectionedReloadDataSource<SettingsSection>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .nightModeItem(let viewModel):
                let cell = (tableView.dequeueReusableCell(withIdentifier: switchReuseIdentifier, for: indexPath) as? SettingSwitchCell)!
                cell.bind(to: viewModel)
                return cell
            case .themeItem(let viewModel),
                 .languageItem(let viewModel),
                 .removeCacheItem(let viewModel):
                let cell = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingCell)!
                cell.bind(to:viewModel)
                return cell
            }
        },titleForHeaderInSection: { dataSource,index in
            let section = dataSource[index]
            return section.title
        })
        output.items.asObservable().bind(to:tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.selectedEvent.drive(onNext:{ [weak self] (item) in
            switch item {
            case .themeItem:
                if let viewModel = viewModel.viewModel(for: item) as? ThemeViewModel {
                   self?.navigator?.show(segue: .theme(viewModel: viewModel), sender: self, transition: .detail)
                }
            case .languageItem:
                if let viewModel = viewModel.viewModel(for: item) as? LanguageViewModel {
                    self?.navigator.show(segue: .language(viewModel: viewModel), sender: self, transition: .detail)
                }
            case .nightModeItem:
                self?.deselectSelectedRow()
            case .removeCacheItem:
                self?.deselectSelectedRow()
                
            }
        }).disposed(by: rx.disposeBag)
    }
}
