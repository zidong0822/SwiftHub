//
//  LanguageViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/22.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Localize_Swift

class LanguageViewModel: ViewModel, ViewModelType {

    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<LanguageCellViewModel>
    }

    struct Output {
        let items: Driver<[LanguageCellViewModel]>
        let selected: Driver<LanguageCellViewModel>
    }

    private var currentLanguage: BehaviorRelay<String>
    
    override init(provider: SwiftHubAPI) {
        currentLanguage = BehaviorRelay(value: Localize.currentLanguage())
        super.init(provider: provider)
    }
    
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[LanguageCellViewModel]>(value: [])
        
        input.trigger.map({ () -> [LanguageCellViewModel] in
            let languages = Localize.availableLanguages(true)
            return languages.map({ (language) -> LanguageCellViewModel in
                let viewModel = LanguageCellViewModel(with: language,currentLanguage: self.currentLanguage.value)
                return viewModel
            })
        }).bind(to: elements).disposed(by: rx.disposeBag)
        
        let selectedEvent = input.selection
        
        selectedEvent.drive(onNext:{ (viewModel) in
            let language = viewModel.language
            self.currentLanguage.accept(language)
            Localize.setCurrentLanguage(language)
        }).disposed(by: rx.disposeBag)
   
        return Output(items: elements.asDriver(),
                      selected: selectedEvent)
    }
}
