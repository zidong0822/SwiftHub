//
//  ThemeViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/21.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class ThemeViewModel: ViewModel, ViewModelType {

    struct Input {
        let refresh: Observable<Void>
        let selection: Driver<ThemeCellViewModel>
    }
    
    struct Output {
        let items: Driver<[ThemeCellViewModel]>
        let selected: Driver<ThemeCellViewModel>
    }
    override init(provider: SwiftHubAPI) {
        super.init(provider: provider)
    }

    func transform(input: Input) -> Output {
        let elements = input.refresh
            .map{ ColorTheme.allValues }
            .map{ $0.map{ ThemeCellViewModel(with: $0)}}
            .asDriver(onErrorJustReturn: [])
        
        let selectedEvent = input.selection
        selectedEvent.drive(onNext:{ (viewModel) in
            let color = viewModel.theme
            let themeType = ThemeType.currentTheme().withColor(color: color)
            themeService.switch(themeType)
        }).disposed(by: rx.disposeBag)
        return Output(items: elements, selected: selectedEvent)
    }

}
