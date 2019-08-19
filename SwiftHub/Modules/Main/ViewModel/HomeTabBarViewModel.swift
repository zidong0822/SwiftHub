//
//  HomeTabBarViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import WhatsNewKit
let loggedIn = BehaviorRelay<Bool>(value: false)
class HomeTabBarViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let whatsNewTrigger: Observable<Void>
    }
    
    struct Output {
        let tabBarItems: Driver<[HomeTabBarItem]>
    }
    
    override init(provider: SwiftHubAPI) {
        super.init(provider: provider)
    }
    
    func transform(input: Input) -> Output {
        let tabBarItems = loggedIn.map { (loggedIn) -> [HomeTabBarItem] in
            return [.search, .login, .settings]
            }.asDriver(onErrorJustReturn: [])
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: HomeTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .search:
            let viewModel = SearchViewModel(provider: provider)
            return viewModel
        case .news:
            let viewModel = SearchViewModel(provider: provider)
            return viewModel
        case .notifications:
            let viewModel = SearchViewModel(provider: provider)
            return viewModel
        case .settings:
            let viewModel = SettingsViewModel(provider: provider)
            return viewModel
        case .login:
            let viewModel = SearchViewModel(provider: provider)
            return viewModel
        }
    }
}
