//
//  SettingSwitchCellViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/20.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingSwitchCellViewModel: DefaultTableViewCellViewModel {

    let isEnabled = BehaviorRelay<Bool>(value: false)
    
    let switchChanged = PublishSubject<Bool>()
    
    init(with title: String, detail: String?, image: UIImage?, hidesDisclosure: Bool, isEnabled: Bool) {
        super.init()
        self.title.accept(title)
        self.secondDetail.accept(detail)
        self.image.accept(image)
        self.hidesDisclosure.accept(hidesDisclosure)
        self.isEnabled.accept(isEnabled)
    }
    
}
