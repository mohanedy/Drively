//
//  Constants.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
struct K {
    
    static let riderRole = "rider"
    static let driverRole = "driver"
    
    struct segues {
        static let loginScreenSegue = "loginScreenSegue"
        static let riderScreenSegue = "riderScreenSegue"
        static let welcomeRiderSegue = "welcomeRiderSegue"
        static let loginDriverSegue = "loginDriverSegue"
        static let welcomeDriverSegue = "welcomeDriverSegue"
        
    }
    
    struct Firestore {
        static let drivelyRequestCollection = "drively_requests"
        struct DrivelyRequestCollectionFields {
            static let email = "email"
            static let location = "location"
        }
    }
}
