//
//  ThemeCell.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/21.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class ThemeCell: DefaultTableViewCell {

    override func makeUI() {
        super.makeUI()
        rightImageView.isHidden = true
        leftImageView.cornerRadius = 20
        leftImageView.snp.remakeConstraints { (make) in
            make.size.equalTo(40)
        }
    }
    
    override func bind(to viewModel: DefaultTableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? ThemeCellViewModel else { return }
        viewModel.imageColor.asDriver().drive(leftImageView.rx.backgroundColor).disposed(by: rx.disposeBag)
    }
}
