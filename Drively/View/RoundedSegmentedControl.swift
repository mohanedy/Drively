//
//  RoundedSegmentedControl.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit


class RoundedSegmentedControl: UISegmentedControl {

    var shadowOfSetWidth : CGFloat = 0
     var shadowOfSetHeight : CGFloat = 5
     
     var shadowColor : UIColor = UIColor.gray
     var shadowOpacity : CGFloat = 0.4

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        
        let font = UIFont(name: "Avenir-Medium", size: 16)
        
        let textAttributes = [
        
            NSAttributedString.Key.font: font,
        
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        
        let cornerRadius = bounds.height/2
               let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
               //background
               clipsToBounds = true
               layer.cornerRadius = cornerRadius
               layer.maskedCorners = maskedCorners
               //foreground
               let foregroundIndex = numberOfSegments
               if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
               {
                   foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: 5, dy: 5)
                   foregroundImageView.image = UIImage()
                   foregroundImageView.highlightedImage = UIImage()
                   foregroundImageView.backgroundColor = UIColor.darkGray
                   foregroundImageView.clipsToBounds = true
                   foregroundImageView.layer.masksToBounds = true

                   foregroundImageView.layer.cornerRadius = 14
                   foregroundImageView.layer.maskedCorners = maskedCorners
               }
    }

}
