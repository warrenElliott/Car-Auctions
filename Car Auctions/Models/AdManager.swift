//
//  AdManager.swift
//  Car Auctions
//
//  Created by Warren Elliott on 02/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import Firebase

class AdManager{
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func uploadDatabaseDestination(_ draft: Bool) -> String{
        
        let destination = (draft ? "DraftsDatabase" : "LiveDatabase")
        return destination
        
    }
    
    func uploadAd(_ ad: AuctionSaleData){
        
        let detailsData = [
            "adID" : ad.adId,
            "adAuthor" : ad.adAuthor,
            "adName" : ad.adName,
            "adDescription" : ad.adDescription,
            "adBid" : ad.adBid,
            "adEnding" : ad.adEnding,
            "adPosted" : ad.datePosted,
            "isDraft" : ad.isDraft,
            "bidCount" : ad.bidCount
            ] as [String : Any]
        
        let adImagesStorage = self.storage.reference()
        let adImageRef = adImagesStorage.child("UserUploadedImagesDraft/adImages \(UUID().uuidString)")
        let detailsReference = self.db.collection(uploadDatabaseDestination(ad.isDraft)).document("adNo__\(ad.adId)")
        
        detailsReference.setData(detailsData, completion: { (error) in
            if let err = error{
                print (err.localizedDescription)
            }
        })
        
        for photo in ad.adImages{
            guard let data = photo?.jpegData(compressionQuality: 1.0) else{return}
            let imageName = UUID().uuidString
            let imageReference = adImageRef.child(imageName)
            
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
                            let dataReference = self.db.collection(self.uploadDatabaseDestination(ad.isDraft)).document("adNo__\(ad.adId)").collection("AdImages").document()
                            let documentUID = dataReference.documentID
                            let data = ["UID": documentUID, "URL": urlString]
                            
                            dataReference.setData(data, completion: { (error  ) in
                                if let err = error{
                                    print (err.localizedDescription)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
