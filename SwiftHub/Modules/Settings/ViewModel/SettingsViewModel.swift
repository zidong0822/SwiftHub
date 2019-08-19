//
//  SettingsViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import Kingfisher
class SettingsViewModel: ViewModel, ViewModelType {

    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<SettingsSectionItem>
    }
    
    struct Output {
        let items: BehaviorRelay<[SettingsSection]>
    }
    func transform(input: SettingsViewModel.Input) -> SettingsViewModel.Output {
        
        let elements = BehaviorRelay<[SettingsSection]>(value: [])
        let removeCache = PublishSubject<Void>()
        
        let cacheRemoved = removeCache.flatMapLatest { () -> Observable<Void> in
            return LibsManager.shared.removeKingfisherCache()
        }
        
        let refresh = Observable.of(input.trigger, cacheRemoved).merge()
        
        let cacheSize = refresh.flatMapLatest { () -> Observable<Int> in
            return LibsManager.shared.kingfisherCacheSize()
        }
        
        Observable.combineLatest(refresh, cacheSize).map { [] (_, size) -> [SettingsSection] in
            let settingCellViewModel = SettingCellViewModel(with:"123", detail:"123", image:UIImage(named:""), hidesDisclosure: false)
            var items: [SettingsSection] = []
            items += [SettingsSection.setting(title:"123",
                                              items:[SettingsSectionItem.profileItem(viewModel: settingCellViewModel),SettingsSectionItem.profileItem(viewModel: settingCellViewModel),SettingsSectionItem.profileItem(viewModel: settingCellViewModel)])]
            return items
            
            
        }.bind(to:elements).disposed(by:rx.disposeBag)
        return Output(items:elements)
    }
}
