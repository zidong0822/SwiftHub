//
//  SearchViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class SearchViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let languageTrigger: Observable<Void>
    }
    
    struct Output {
        let sortItems: Driver<[String]>
    }
    let searchType = BehaviorRelay<SearchTypeSegments>(value: .repositories)
    
    func transform(input: SearchViewModel.Input) -> SearchViewModel.Output {
        let sortItems = Observable.combineLatest(searchType,input.languageTrigger)
            .map{ (searchType,_) -> [String] in
            return [String]()
        }.asDriver(onErrorJustReturn: [])
        return Output(sortItems:sortItems)
    }
}
