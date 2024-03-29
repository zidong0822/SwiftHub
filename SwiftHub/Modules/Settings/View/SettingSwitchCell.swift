//
//  SettingSwitchCell.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/20.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class SettingSwitchCell: DefaultTableViewCell {
    
    lazy var switchView: Switch = {
        let view = Switch()
        return view
    }()
    
    override func makeUI() {
        super.makeUI()
        leftImageView.contentMode = .center
        leftImageView.snp.remakeConstraints { (make) in
            make.size.equalTo(40)
        }
        stackView.insertArrangedSubview(switchView, at: 2)
        themeService.rx
            .bind({ $0.secondary }, to: leftImageView.rx.tintColor)
            .disposed(by: rx.disposeBag)
    }
    
    override func bind(to viewModel: DefaultTableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? SettingSwitchCellViewModel else { return }
        
        viewModel.isEnabled.asDriver().drive(switchView.rx.isOn).disposed(by: rx.disposeBag)
        switchView.rx.isOn.bind(to: viewModel.switchChanged).disposed(by: rx.disposeBag)
    }
}
