//
//  RiderServices.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/8/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import FirebaseFirestore
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
        firestore.collection(K.Firestore.drivelyRequestCollection).whereField(K.Firestore.DrivelyRequestCollectionFields.email, isEqualTo: email).getDocuments(completion: { (snapshot, error) in
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
        firestore.collection(K.Firestore.drivelyRequestCollection).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print(err)
            }else{
                if let docs = querySnapshot?.documents{
                    var requestsList:[DrivelyRequest] = []
                    for doc in docs {
                        if let request = try?  doc.data(as: DrivelyRequest.self){
                            requestsList.append(request)
                            
                        }
                        
                    }
                    onCompletion(requestsList,nil)
                }
                
            }
        }
        
    }
    
    
    
}
