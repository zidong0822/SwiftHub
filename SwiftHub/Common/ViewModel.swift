//
//  ViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//
import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    let provider: SwiftHubAPI
    init(provider: SwiftHubAPI){
       self.provider = provider
       super.init()
    }
}
