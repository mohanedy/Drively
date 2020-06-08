//
//  Constants.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
struct K {
    struct segues {
        static let loginScreenSegue = "loginScreenSegue"
        static let riderScreenSegue = "riderScreenSegue"
        static let welcomeRiderSegue = "welcomeRiderSegue"
    }
    
    struct Firestore {
        static let drivelyRequestCollection = "drively_requests"
        struct DrivelyRequestCollectionFields {
            static let email = "email"
            static let location = "location"
        }
    }
}
