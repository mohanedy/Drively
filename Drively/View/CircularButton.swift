//
//  CircularButton.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
@IBDesignable
class CircularButton: UIButton {
    
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    
    var shadowColor : UIColor = UIColor.gray
    var shadowOpacity : CGFloat = 0.5
    
    
    @IBInspectable
    var fillColor:CGColor = UIColor.black.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        
        
        let cornerRadius = frame.width / 2
        layer.cornerRadius = cornerRadius
        imageView?.contentMode = .scaleAspectFill
        
        layer.shadowColor = shadowColor.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
    
}
