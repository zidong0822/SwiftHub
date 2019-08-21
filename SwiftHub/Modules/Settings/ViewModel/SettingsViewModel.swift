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
import Rswift
class SettingsViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<SettingsSectionItem>
    }
    
    struct Output {
        let items: BehaviorRelay<[SettingsSection]>
        let selectedEvent: Driver<SettingsSectionItem>
    }
    
    let nightModeEnabled: BehaviorRelay<Bool>
    
    var cellDisposeBag = DisposeBag()
    
    override init(provider: SwiftHubAPI) {
        nightModeEnabled = BehaviorRelay(value: ThemeType.currentTheme().isDark)
        super.init(provider: provider)
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
            var items: [SettingsSection] = []
            let nightModeEnabled = self.nightModeEnabled.value
            let nightModeCellViewModel = SettingSwitchCellViewModel(with: R.string.localizable.settingsNightModeTitle.key.localized(), detail: nil,
                                                                    image: R.image.icon_cell_night_mode()?.template, hidesDisclosure: true, isEnabled: nightModeEnabled)
            nightModeCellViewModel.switchChanged.skip(1).bind(to: self.nightModeEnabled).disposed(by: self.cellDisposeBag)
            
            let themeCellViewModel = SettingCellViewModel(with: R.string.localizable.settingsThemeTitle.key.localized(), detail: nil,
                                                          image: R.image.icon_cell_theme()?.template, hidesDisclosure: false)
            
            items += [SettingsSection.setting(title:R.string.localizable.settingsPreferencesSectionTitle.key.localized(),
                                              items:[SettingsSectionItem.nightModeItem(viewModel:nightModeCellViewModel),
                                                     SettingsSectionItem.themeItem(viewModel:themeCellViewModel)]
                )]
            return items
            
            }.bind(to:elements).disposed(by:rx.disposeBag)
        
        let selectedEvent = input.selection
        
        nightModeEnabled.subscribe(onNext: { (isEnabled) in
            var theme = ThemeType.currentTheme()
            if theme.isDark != isEnabled {
                theme = theme.toggled()
            }
            themeService.switch(theme)
        }).disposed(by: rx.disposeBag)
        
        
        return Output(items: elements,selectedEvent:selectedEvent)
    }
    
    func viewModel(for item: SettingsSectionItem) -> ViewModel? {
        switch item {
        case .themeItem:
            return ThemeViewModel(provider:self.provider)
        default:
            return nil
        }
    }
}
