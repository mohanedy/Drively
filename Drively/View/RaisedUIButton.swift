//
//  RaisedUIButton.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

@IBDesignable
class RaisedUIButton: UIButton {
    var shadowOfSetWidth : CGFloat = 0
     var shadowOfSetHeight : CGFloat = 5
     
     var shadowColor : UIColor = UIColor.gray
     var shadowOpacity : CGFloat = 0.4
    @IBInspectable
       var cornerRadius: CGFloat  {
           set {
            
               layer.cornerRadius = newValue
           }
           get {
               return layer.cornerRadius
           }
       }
    
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
       semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
      layer.cornerRadius = cornerRadius
              layer.shadowColor = shadowColor.cgColor
              
              layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
              
              let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
              
              layer.shadowPath = shadowPath.cgPath
              
              layer.shadowOpacity = Float(shadowOpacity)
    }
 

}
