//
//  AdManager.swift
//  Car Auctions
//  this file manages all new ads and stores them to the remote Firestore database
//  Created by Warren Elliott on 02/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import Firebase

class AdManager{
    
    let db = Firestore.firestore() //init Firebase
    let storage = Storage.storage() //init storage
    
    func uploadDatabaseDestination(_ draft: Bool) -> String{
        
        let destination = (draft ? "DraftsDatabase" : "LiveDatabase")
        return destination
        
    } // function dictates wether this will be uploaded in the Drafts or live, based on condition
    
    func uploadAd(_ ad: AuctionSaleData){
        
        let adImagesStorage = self.storage.reference() //reference to the storage on Firebase
        let adImageRef = adImagesStorage.child("UserUploadedImagesDraft/ \(ad.adId)")
        // storage destination in Firebase
        let detailsReference = self.db.collection(uploadDatabaseDestination(ad.isDraft)).document("\(ad.adId)")
        let bidDetailsReference = self.db.collection(uploadDatabaseDestination(ad.isDraft)).document("\(ad.adId)")
        
        //gives the ad an ID in Firebase for reference
        
        let detailsData = [
            "adID" : ad.adId,
            "adAuthor" : ad.adAuthor,
            "adName" : ad.adName,
            "adDescription" : ad.adDescription,
            "adBid" : ad.adBid,
            "adEndingDate" : ad.adEndingDate,
            "adEndingTime" : ad.adEndingTime,
            "adPosted" : ad.datePosted,
            "isDraft" : ad.isDraft,
            "adLocation" : ad.adLocation,
            "bidCount" : ad.bidCount,
            ] as [String : Any] //creates a little data dictionary to dictate how data will be stored in the database
    
        detailsReference.setData(detailsData, completion: { (error) in
            if let err = error{
                print (err.localizedDescription)
            }
        })
        
        var urlStrings = [String]() //list of URL's where the images that belong to this ad are stored remotely
        
        for photo in ad.adImages{ //photo uploader
            
            guard let data = photo?.jpegData(compressionQuality: 1.0) else{return} //converts image
            let imageName = UUID().uuidString //give a unique ID  generated by Swift to the image
            let imageReference = adImageRef.child(imageName) //instructions on how to store it
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if let error = error{
                    print (error.localizedDescription)
                    return
                }
                
                else{
                    imageReference.downloadURL { (url, error) in
                        if let error = error{
                            print (error.localizedDescription)
                            return
                        }
                        else{
                            guard let url = url else{
                                return
                            }
                            
                            
                            
                            let urlString = url.absoluteString
                            urlStrings.append(urlString)
                            
                            detailsReference.updateData(["imageURLs" : urlStrings]) { (error) in
                                if let err = error{
                                    print (err.localizedDescription)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func increaseBid(forAd adSummary: AuctionSaleData, editValue: String, bidCount: String){
        
        let bidID = UUID().uuidString
        
        let bidReference = self.db.collection("LiveDatabase").document("\(adSummary.adId)")
        
//        let bidHistoryReference = self.db.collection("LiveDatabase").document("\(adSummary.adId)").collection("bids").document(bidID)
//
//        let bidHistoryEntry = [
//
//            "bidID" : UUID().uuidString,
//            "bidder" : UserDefaults.standard.value(forKey: "userEmail"),
//            "bidValue": editValue,
//            "timestamp": Date().timeIntervalSince1970
//
//        ] as [String : Any]
        
        
        bidReference.updateData([
            
            "bids": FieldValue.arrayUnion([[
                "bidAuthor": UserDefaults.standard.value(forKey: "userEmail"),
                "bidValue": editValue,
                "timestamp": Date().timeIntervalSince1970
            ]]),
            "adBid": "\(editValue)",
            "bidCount": "\(bidCount)"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
//        bidHistoryReference.setData(bidHistoryEntry, completion: { (error) in
//            if let err = error{
//                print (err.localizedDescription)
//            }else{
//                print("saved")
//
//            }
//        })
        
    }
    
    func addToUserBids(forAd ad: AuctionSaleData, user: String, userBidValue: String){
    
        
        let userReference = self.db.collection("Users").document("\(user)").collection("UserBids").document(ad.adId)
        
        let detailsData = [
            "adID" : ad.adId,
            "adAuthor" : ad.adAuthor,
            "adName" : ad.adName,
            "adDescription" : ad.adDescription,
            "adBid" : ad.adBid,
            "adEndingDate" : ad.adEndingDate,
            "adEndingTime" : ad.adEndingTime,
            "adPosted" : ad.datePosted,
            "isDraft" : ad.isDraft,
            "adLocation" : ad.adLocation,
            "bidCount" : ad.bidCount,
            "imageURLs" : ad.imageLinks,
            "userBidValue" : userBidValue,
            ] as [String : Any] //creates a little data dictionary to dictate how data will be stored in the database
    
        userReference.setData(detailsData, completion: { (error) in
            if let err = error{
                print (err.localizedDescription)
            }
        })
    
    }
    
    func updateAddToUserBids(forAd adSummary: AuctionSaleData, editValue: String, bidCount: String){
        
        let user = UserDefaults.standard.value(forKey: "userEmail") as! String
        
        let bidReference = self.db.collection("Users").document("\(user)").collection("UserBids").document(adSummary.adId)

        bidReference.updateData([
            
            "bids": FieldValue.arrayUnion([[
                "bidAuthor": user,
                "bidValue": editValue,
                "timestamp": Date().timeIntervalSince1970
            ]]),
            "adBid": "\(editValue)",
            "bidCount": "\(bidCount)"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}

