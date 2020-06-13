//
//  DrivelyRequest.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/8/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct DrivelyRequest : Codable {
    var key:String?
    let email:String
    let location:GeoPoint
    var driver:GeoPoint = GeoPoint(latitude: 0, longitude: 0)
    
    
    private enum CodingKeys: String, CodingKey{
        case email, location, driver
    }
}
