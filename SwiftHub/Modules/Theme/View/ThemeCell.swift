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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        rightImageView.image = selected ? R.image.icon_cell_check()?.template : nil
    }
    
}
