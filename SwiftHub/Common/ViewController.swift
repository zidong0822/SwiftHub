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
    var navigator: Navigator?
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
    
    let languageChanged = BehaviorRelay<Void>(value: ())
    
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
    }
    
    func makeUI(){
        themeService.rx
            .bind({ $0.primaryDark }, to: view.rx.backgroundColor)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel(){
        
    }
    
    func updateUI() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(nibName: nil, bundle: nil)
    }
}
