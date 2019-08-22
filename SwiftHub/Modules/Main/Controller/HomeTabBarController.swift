//
//  HomeTabBarController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//
import UIKit
import Localize_Swift
import RxSwift
import RxViewController
import RxCocoa
import NSObject_Rx
enum HomeTabBarItem: Int {
    case search, news, notifications, settings, login
    
    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
        case .search:
            let vc = SearchViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        case .news:
            let vc = EventsViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        case .notifications:
            let vc = NotificationsViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        case .settings:
            let vc = SettingsViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        case .login:
            let vc = LoginViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .search: return R.image.icon_tabbar_search()
        case .news: return R.image.icon_tabbar_news()
        case .notifications: return R.image.icon_tabbar_activity()
        case .settings: return R.image.icon_tabbar_settings()
        case .login: return R.image.icon_tabbar_login()
        }
    }
    
    var title: String {
        switch self {
        case .search: return R.string.localizable.homeTabBarSearchTitle.key.localized()
        case .news: return R.string.localizable.homeTabBarEventsTitle.key.localized()
        case .notifications: return R.string.localizable.homeTabBarNotificationsTitle.key.localized()
        case .settings: return R.string.localizable.homeTabBarSettingsTitle.key.localized()
        case .login: return R.string.localizable.homeTabBarLoginTitle.key.localized()
        }
    }
    
    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let vc = controller(with: viewModel, navigator: navigator)
        let item = UITabBarItem(title:title, image:image, tag: rawValue)
//        if let selectedImage = image {
//            item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
//        }
        
        
        vc.tabBarItem = item
        return vc
    }
}

class HomeTabBarController: UITabBarController, Navigatable {
    
    var viewModel: HomeTabBarViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel as? HomeTabBarViewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {
        themeService.rx
            .bind({ $0.secondary }, to: tabBar.rx.tintColor)
            .bind({ $0.primaryDark }, to: tabBar.rx.barTintColor)
            .disposed(by: rx.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
            .subscribe { [weak self] (event) in
                self?.tabBar.items?.forEach({ (item) in
                    item.title = HomeTabBarItem(rawValue: item.tag)?.title
                })
            }.disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        let input = HomeTabBarViewModel.Input(whatsNewTrigger: rx.viewDidAppear.mapToVoid())
        let output = viewModel.transform(input: input)
        output.tabBarItems.drive(onNext: { [weak self] (tabBarItems) in
            if let strongSelf = self {
                let controllers = tabBarItems.map{$0.getController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by:rx.disposeBag)
    }
}
