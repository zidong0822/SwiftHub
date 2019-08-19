//
//  Application.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
//final关键字防止被重写
final class Application: NSObject {
    static let shared = Application()
    var window: UIWindow?
    var provider: SwiftHubAPI?
    let navigator: Navigator
    //私有化防止再其他位置实例化
    private override init() {
        navigator = Navigator.default
        super.init()
        provider =  RestApi()
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window, let provider = provider else { return }
        self.window = window
        let viewModel = HomeTabBarViewModel(provider: provider)
        self.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
}
