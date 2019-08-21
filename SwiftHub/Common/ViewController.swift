//
//  ViewController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    var viewModel: ViewModel?
    var navigator: Navigator!
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    var automaticallyAdjustsLeftBarButtonItem = true
    
    let languageChanged = BehaviorRelay<Void>(value: ())
    
    lazy var backBarButton: BarButtonItem = {
        let view = BarButtonItem()
        view.title = ""
        return view
    }()
    
    lazy var closeBarButton: BarButtonItem = {
        let view = BarButtonItem(image: R.image.icon_navigation_close(),
                                 style: .plain,
                                 target: self,
                                 action: nil)
        return view
    }()
    
    lazy var contentView: View = {
        let view = View()
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        return view
    }()
    
    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        view.spacing = 0
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()

        closeBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: rx.disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
        updateUI()
    }
    
    func makeUI(){
        
        navigationItem.backBarButtonItem = backBarButton
        
        themeService.rx
            .bind({ $0.primaryDark }, to: view.rx.backgroundColor)
            .bind({ $0.secondary}, to: [backBarButton.rx.tintColor, closeBarButton.rx.tintColor])
            .disposed(by: rx.disposeBag)
       
        updateUI()
    }
    
    func bindViewModel(){
        
    }
    
    func updateUI() {
        
    }
    
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // presented
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(nibName: nil, bundle: nil)
    }
}

