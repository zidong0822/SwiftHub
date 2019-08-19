//
//  StackView.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class StackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        spacing = inset
        axis = .vertical
        // self.distribution = .fill
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }

}
