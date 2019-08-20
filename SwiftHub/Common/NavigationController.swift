//
//  NavigationController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxSwift
class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        
        globalStatusBarStyle.mapToVoid().subscribe(onNext:{ [weak self] () in
            self?.setNeedsStatusBarAppearanceUpdate()
        }).disposed(by: rx.disposeBag)
        
        themeService.rx
            .bind({ $0.secondary }, to: navigationBar.rx.tintColor)
            .bind({ $0.primaryDark }, to: navigationBar.rx.barTintColor)
            .bind({ [NSAttributedString.Key.foregroundColor: $0.text] }, to: navigationBar.rx.titleTextAttributes)
            .disposed(by: rx.disposeBag)
    }

}
