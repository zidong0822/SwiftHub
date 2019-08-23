//
//  ThemeCellViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/21.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThemeCellViewModel: DefaultTableViewCellViewModel {

    let imageColor = BehaviorRelay<UIColor?>(value: nil)
    
    let theme: ColorTheme

    init(with theme: ColorTheme){
        self.theme = theme
        super.init()
        title.accept(theme.title)
        imageColor.accept(theme.color)
    }

}
