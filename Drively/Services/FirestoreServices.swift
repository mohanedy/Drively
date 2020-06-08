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
                let decoder = JSONDecoder()
                if let data = try?  JSONSerialization.data(withJSONObject: snapshot!.documents.first!, options: []) {
                   let request = try? decoder.decode(DrivelyRequest.self, from: data)
                    
                    onCompletion(request, nil)
                    
                }
                
            }
        })
        
    }
    
    
    
}