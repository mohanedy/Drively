//
//  DriverMapViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/12/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class DriverMapViewController: UIViewController,FirestoreServices {
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var goButton: CircularButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var rideState:RideState = .notSpecified
    
    var selectedRequest:DrivelyRequest?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        initData()
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { (_) in
            if let location = self.locationManager.location{
                self.updateDriverLocation(request: self.selectedRequest!, location: GeoPoint.init(locationCoordinates: location))
                  }
        }
    }
    
    func initData() {
        if let request = selectedRequest{
            emailLabel.text = request.email
            let userLocation = CLLocation(latitude: request.location.latitude, longitude: request.location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation.coordinate
            annotation.title = "\(request.email)"
            mapView.addAnnotation(annotation)
            if let loc =  locationManager.location{
                let distance = Utils.calculateDistance(from: loc, to: userLocation)
                distanceLabel.text = "\(distance) KM"
                durationLabel.text = "5 MIN"
                
            }
            
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        
        switch rideState {
            
        case .notSpecified:
            startRide()
            break
            
        case .onGoing:
            UIServices.displaySuccessAlert(title: "Well Done", msg: "You have completed your ride successfully !")
            finish(request: selectedRequest!)
            self.dismiss(animated: true, completion: nil)
            break
            
        case .stopped:
            print("Stopped")
            break
            
        }
        
    }
    
    func startRide() {
        if let request = selectedRequest{
            if let location = locationManager.location{
                accept(request: request, acceptedDriverLocation: GeoPoint(locationCoordinates: location)) { (error) in
                    if let err = error{
                        UIServices.displayErrorAlert(errorTitle: "Error", msg: err.localizedDescription)
                    }else{
                        self.rideState = .onGoing
                        self.goButton.backgroundColor = .red
                        self.goButton.setTitle("STOP", for: .normal)
                        self.goButton.titleLabel?.font = UIFont(name: "Avenir", size: 18)
                        CLGeocoder().reverseGeocodeLocation(request.location.toCLLocation( )) { (placemarks, error) in
                            if let safePlaceMarks = placemarks{
                                if safePlaceMarks.count>0{
                                    let mark = MKPlacemark(placemark: safePlaceMarks[0])
                                    
                                    let mapItem = MKMapItem(placemark: mark)
                                    mapItem.name = request.email
                                    let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                                    mapItem.openInMaps(launchOptions: options)
                                    
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
}

//MARK: - CLLOCATION DELEGATE METHODS
extension DriverMapViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
    }
    
}

enum RideState {
    case notSpecified, onGoing, stopped
}
