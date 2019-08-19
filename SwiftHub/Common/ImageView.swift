//
//  ImageView.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        makeUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        tintColor = .primary()
        layer.masksToBounds = true
        contentMode = .center
        
        hero.modifiers = [.arc]
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
