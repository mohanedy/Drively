//
//  RiderViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/6/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore
class RiderViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,FirestoreServices {
    
    @IBOutlet weak var orderDrivelyButton: RaisedUIButton!
    
    let annotationIdentifier = "AnnotationIdentifier"
    @IBOutlet weak var mapView: MKMapView!
    
    var annotationView: MKAnnotationView?
    var driverAnnotation = MKPointAnnotation()
    var riderAnnotation = MKPointAnnotation()

    var locationManager = CLLocationManager()
    var isDrivelyCalled = false
    var requestState:RideRequestState = .notRequested
    var driverLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapView.delegate = self
            riderAnnotation.title = "rider"
            driverAnnotation.title = "driver"
            mapView.addAnnotations([riderAnnotation,driverAnnotation])
            
        }
        
    }
    
    func initData(){
        if let currentUser = Auth.auth().currentUser{
            getCurrentRequest(forEmail: currentUser.email!) { (request, _ ) in
                if let safeRequest = request{
                    
                    if safeRequest.driver.latitude == 0 && safeRequest.driver.longitude == 0{
                        self.requestState = .requested
                        
                    }else{
                        self.requestState = .onGoing
                        self.driverLocation = safeRequest.driver.toCLLocation()
                        self.displayAnnotations()
                    }
                    
                    DispatchQueue.main.async {
                        self.updateUI()
                        
                    }
                }
            }
            
        }
        
    }
    
    func displayAnnotations(){
        if let userLocation = locationManager.location{
            if requestState == .onGoing{
                updateUI()
                if let driverLocation = driverLocation{
                    let latDelta = abs(driverLocation.coordinate.latitude - userLocation.coordinate.latitude) * 2 + 0.005
                    let lonDelta = abs(driverLocation.coordinate.longitude - userLocation.coordinate.longitude) * 2 + 0.005
                    
                    let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
                    mapView.setRegion(region, animated: true)
                    riderAnnotation.coordinate = userLocation.coordinate
                    driverAnnotation.coordinate = driverLocation.coordinate

                }
            }else{
                
                let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
                riderAnnotation.coordinate = center
                riderAnnotation.title = "Your location"
                
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        displayAnnotations()
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            if annotation.title == "driver"{
                annotationView.canShowCallout = true
                      annotationView.image = UIImage(named: "driver-marker")
            }else{
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "location")
        }
        }
        
        return annotationView
    }
    
    
    
    
    @IBAction func orderDrively(_ sender: UIButton) {
        
        
        if requestState == .onGoing{
            requestState = .notRequested
            updateUI()
            return
        }
        
        if let currentUser = Auth.auth().currentUser{
            
            
            if requestState == .notRequested{
                
                if let latestLocation = locationManager.location{
                    
                    let currentLocation  = GeoPoint(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
                    submitDrivelyRequest(request: DrivelyRequest(key: nil, email: currentUser.email!, location: currentLocation) ) { (error) in
                        if let safeError = error{
                            UIServices.displayErrorAlert(errorTitle: "Can't order drively", msg: "sorry we can't order drively at the moment check your internet connection \(safeError.localizedDescription)")
                        }else{
                            UIServices.displaySuccessAlert(title: "Done !", msg: "We have ordered drively successfully")
                            self.requestState = .requested
                            self.updateUI()
                            
                            
                        }
                    }
                }
            }else{
                removeDrively(forEmail: currentUser.email!) { (error) in
                    if let safeError = error{
                        UIServices.displayErrorAlert(errorTitle: "Can't cancel order", msg: "sorry we can't cancel order drively at the moment check your internet connection \(safeError.localizedDescription)")
                    }else{
                        UIServices.displaySuccessAlert(title: "Done !", msg: "We have canceled drively successfully")
                        self.requestState = .notRequested
                        self.updateUI()
                        
                    }
                }
            }
        }
    }
    
    func updateUI() {
        if requestState == .requested{
            orderDrivelyButton.setTitle("Cancel Drively", for: .normal)
            
        }else if requestState == .onGoing {
            if let driverLocation = driverLocation{
                if let userLocation = locationManager.location{
                    let distance = Utils.calculateDistance(from: driverLocation, to: userLocation)
                    orderDrivelyButton.setTitle("The driver is \(distance) KM away", for: .normal)
                }
            }
            
        }else{
            orderDrivelyButton.setTitle("Drively Now", for: .normal)
            
            
        }
    }
}

enum RideRequestState{
    case requested,notRequested, onGoing
}
