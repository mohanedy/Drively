//
//  Double+FormatToPoints.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/11/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
extension Double {

    func truncate(places: Int) -> Double {

        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal

    }

}


