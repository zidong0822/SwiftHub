//
//  LanguageCell.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/22.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class LanguageCell: DefaultTableViewCell {

    override func makeUI() {
        super.makeUI()
        leftImageView.isHidden = true
    }
    
    
    
    override func bind(to viewModel: DefaultTableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? LanguageCellViewModel else { return }
        rightImageView.image = viewModel.language == viewModel.currentLanguage ?  R.image.icon_cell_check()?.template : nil
    }
    
}
