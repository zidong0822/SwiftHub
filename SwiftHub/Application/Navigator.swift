//
//  Navigator.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//
import Foundation
import UIKit
import Hero
protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator: NSObject {
    static var `default` = Navigator()
    
    enum Scene {
        case tabs(viewModel: HomeTabBarViewModel)
        case theme(viewModel: ThemeViewModel)
        case language(viewModel: LanguageViewModel)
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs(let viewModel):
            let rootVC = HomeTabBarController(viewModel: viewModel, navigator: self)
            return rootVC
        case .theme(let viewModel):
            let themeVC = ThemeViewController(viewModel: viewModel, navigator: self)
            return themeVC
        case .language(let viewModel):
            let languageVC = LanguageViewController(viewModel: viewModel, navigator: self)
            return languageVC
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
     private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        default:
            break
        }
    }
}
