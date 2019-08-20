//
//  Switch.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/20.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class Switch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        themeService.rx
            .bind({ $0.secondary }, to: [rx.tintColor, rx.onTintColor])
            .disposed(by: rx.disposeBag)
    }
}
