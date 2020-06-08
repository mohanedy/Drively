//
//  UIServices.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/9/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import SCLAlertView

struct UIServices {
   static func displayErrorAlert(errorTitle:String, msg:String) {
           SCLAlertView().showError(errorTitle,subTitle: msg)
       }
    
    static func displaySuccessAlert(title:String, msg:String) {
            SCLAlertView().showSuccess(title, subTitle: msg)
        }

}
