//
//  GeoPoint+CLLocation.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/12/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

extension GeoPoint{
    convenience init(locationCoordinates:CLLocation) {
        
        
        self.init(latitude: locationCoordinates.coordinate.latitude,longitude: locationCoordinates.coordinate.longitude)
        
    }
    
    
    func toCLLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
