//
//  CustomUITextField.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit


@IBDesignable
class CustomUITextField: UITextField {
    
    var shadowOfSetWidth : CGFloat = 0
     var shadowOfSetHeight : CGFloat = 5
     
     var shadowColor : UIColor = UIColor.gray
     var shadowOpacity : CGFloat = 0.4

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        textFieldSetup()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textFieldSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        textFieldSetup()
    }
    
    func textFieldSetup() {
        layer.cornerRadius = 15
        layer.shadowColor = shadowColor.cgColor
        layer.borderColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 15)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = Float(shadowOpacity)
    }
    

}
