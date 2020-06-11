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
  static  func formatNumber(_ n: Int) -> String {

        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {

        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"

        }

    }
}
