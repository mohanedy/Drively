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
    
    var locationManager = CLLocationManager()
    var isDrivelyCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapView.delegate = self
            
        }
        
        
    }
    
    func initData(){
        if let currentUser = Auth.auth().currentUser{
            getCurrentRequest(forEmail: currentUser.email!) { (request, _ ) in
                if let _ = request{
                    self.isDrivelyCalled = true
                    self.updateUI()
                }
            }

        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate{
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
            mapView.removeAnnotations(mapView.annotations)
            let currentAnnotation = MKPointAnnotation()
            currentAnnotation.coordinate = center
            currentAnnotation.title = "Your location"
            mapView.addAnnotation(currentAnnotation)
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Better to make this class property
        
        
        var annotationView: MKAnnotationView?
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
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "location")
        }
        
        return annotationView
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func orderDrively(_ sender: UIButton) {
        if let currentUser = Auth.auth().currentUser{
            if !isDrivelyCalled{
                
                if let latestLocation = locationManager.location{
                    
                    let currentLocation  = GeoPoint(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
                    submitDrivelyRequest(request: DrivelyRequest(key: nil, email: currentUser.email!, location: currentLocation) ) { (error) in
                        if let safeError = error{
                            UIServices.displayErrorAlert(errorTitle: "Can't order drively", msg: "sorry we can't order drively at the moment check your internet connection \(safeError.localizedDescription)")
                        }else{
                            UIServices.displaySuccessAlert(title: "Done !", msg: "We have ordered drively successfully")
                            self.isDrivelyCalled = true
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
                        self.isDrivelyCalled = false
                        self.updateUI()
                        
                    }
                }
            }
        }
    }
    
    func updateUI() {
        if isDrivelyCalled{
            orderDrivelyButton.setTitle("Cancel Drively", for: .normal)

        }else{
            orderDrivelyButton.setTitle("Drively Now", for: .normal)


        }
    }
}
