//
//  RiderServices.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/8/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit
protocol FirestoreServices {
    
}

extension FirestoreServices{
    var firestore: Firestore { return Firestore.firestore() }
    
    func submitDrivelyRequest(request:DrivelyRequest, onCompletion: @escaping (Error?) -> Void) {
        do {
            _ =  try firestore.collection(K.Firestore.drivelyRequestCollection).addDocument(from: request,completion: onCompletion)
        } catch  {
            onCompletion(error)
        }
        
    }
    
    func removeDrively(forEmail email:String, onCompletion: @escaping (Error?) -> Void) {
        firestore.collection(K.Firestore.drivelyRequestCollection).whereField(K.Firestore.DrivelyRequestCollectionFields.email, isEqualTo: email).getDocuments(completion: { (snapshot, error) in
            if let safeError = error{
                onCompletion(safeError)
            }else{
                for doc in snapshot!.documents{
                    self.firestore.collection(K.Firestore.drivelyRequestCollection).document(doc.documentID).delete()
                }
                onCompletion(nil)
            }
        })
        
    }
    
    func getCurrentRequest(forEmail email:String, onCompletion: @escaping (DrivelyRequest?,Error?) -> Void) {
        firestore.collection(K.Firestore.drivelyRequestCollection).whereField(K.Firestore.DrivelyRequestCollectionFields.email, isEqualTo: email).addSnapshotListener({ (snapshot, error) in
            if let safeError = error{
                onCompletion(nil, safeError)
            }else{
                if let firstItem = snapshot?.documents.first{
                    if let request = try?  firstItem.data(as: DrivelyRequest.self){
                        onCompletion(request, nil)
                        return
                    }
                }
                onCompletion(nil,nil)
            }
        })
        
    }
    
    func getRequests(onCompletion: @escaping ([DrivelyRequest],Error?) -> Void) {
        firestore.collection(K.Firestore.drivelyRequestCollection).whereField(K.Firestore.DrivelyRequestCollectionFields.driver, isEqualTo: GeoPoint(latitude: 0, longitude: 0)).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print(err)
            }else{
                if let docs = querySnapshot?.documents{
                    var requestsList:[DrivelyRequest] = []
                    for doc in docs {
                        var request = try?  doc.data(as: DrivelyRequest.self)
                        request?.key = doc.documentID
                        if let safeRequest = request  {
                            requestsList.append(safeRequest)
                            
                        }
                        
                    }
                    onCompletion(requestsList,nil)
                }
                
            }
        }
        
    }
    
    func accept(request:DrivelyRequest, acceptedDriverLocation userLocation:GeoPoint, onCompletion: @escaping (Error?) -> Void)  {
        firestore.collection(K.Firestore.drivelyRequestCollection).document(request.key!).updateData(["driver":userLocation],completion: onCompletion)
    }
    
    
    func finish(request:DrivelyRequest)  {
        firestore.collection(K.Firestore.drivelyRequestCollection).document(request.key!).delete()
    }
    
    func  updateDriverLocation(request:DrivelyRequest,location:GeoPoint) {
        if let key = request.key{
        firestore.collection(K.Firestore.drivelyRequestCollection).document(key).updateData([K.Firestore.DrivelyRequestCollectionFields.driver:location])
            
        }
    }
    
}


