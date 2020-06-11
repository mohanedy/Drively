//
//  DriverRequestsTableViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/10/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import MapKit
class DriverRequestsTableViewController: UITableViewController, FirestoreServices {
    
    let emptyStateMessage = "There's No Requests Nearby 😢"
    let locationManager = CLLocationManager()
    var requestList:[DrivelyRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        setupTableView()
        
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: K.driverTableViewCellNibName, bundle: nil), forCellReuseIdentifier: K.driverTableCellIdentifier)
        tableView.rowHeight = 75
        getRequests { (requests, error) in
            self.requestList = requests
            self.tableView.updateTableView(sectionNum: 0, message: self.emptyStateMessage)

        }

    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.driverTableCellIdentifier, for: indexPath) as! RequestsTableViewCell
        
        let userLocation = CLLocation(latitude: requestList[indexPath.row].location.latitude, longitude: requestList[indexPath.row].location.longitude)
        let distance = round((userLocation.distance(from: locationManager.location!)/1000)*100)/100
        cell.distance = distance
        cell.email = requestList[indexPath.row].email
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMarks, error) in
            if let placeMark = placeMarks?.first{
                cell.location = placeMark.name!
            }
        }
        
        
        return cell
    }
    
    
    
}

//MARK: - Location Manager Delegate Methods
extension DriverRequestsTableViewController :  CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
}
