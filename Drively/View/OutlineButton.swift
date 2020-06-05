//
//  OutlineButton.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

@IBDesignable
class OutlineButton: UIButton {

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
     layer.cornerRadius = cornerRadius
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
   }

}
