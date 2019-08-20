//
//  LibsManager.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
class LibsManager: NSObject {
    static let shared = LibsManager()
    
    private override init() {
        super.init()
        // ImageCache.default.rx
    }
    
    func setupLibs(with window:UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupTheme()
    }
    
    func setupTheme() {
        themeService.rx
            .bind({$0.statusBarStyle}, to: UIApplication.shared.rx.statusBarStyle)
            .disposed(by: rx.disposeBag)
    }
    
}

extension LibsManager {
    
    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }
    
    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}
