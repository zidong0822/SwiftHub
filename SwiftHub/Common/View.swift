//
//  View.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//
import UIKit
import SnapKit
public class View: UIView {
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
}

extension UIView {
    
    var inset: CGFloat {
        return Configs.BaseDimensions.inset
    }
    
    open func setPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        self.setContentHuggingPriority(priority, for: axis)
        self.setContentCompressionResistancePriority(priority, for: axis)
    }
}
