//
//  LoadContent.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import Firebase
import Combine

class LoadContent: ObservableObject{
    
    @Published var content = [AuctionSaleData]()


    let db = Firestore.firestore() //reference to the database
    let storage = Storage.storage() //reference to the storage
    
    func fetchData(dataQuery: Query){
        
        dataQuery.addSnapshotListener { (querySnapshot, error) in

            if let e = error{

                print (e.localizedDescription)

            }

            else{
                
                var pageContent = [AuctionSaleData]()
                

                if let snapshotDocs = querySnapshot?.documents{ //tap into the query documents

                    for doc in snapshotDocs{ //for each entry in this document

                        let data = doc.data() //the data present inside each doc
                        let adID = data["adID"] as! String
                        //self.fetchImageURLs(id: adID)
                        
                        var instance = AuctionSaleData(adId: adID,
                                                       adName: data["adName"] as! String,
                                                       adDescription: data["adDescription"] as! String,
                                                       adBid: data["adBid"] as! String,
                                                       adEndingTime: data["adEndingTime"] as? String ?? "",
                                                       adEndingDate: data["adEndingDate"] as? String ?? "",
                                                       adAuthor: data["adAuthor"] as! String,
                                                       adLocation: data["adLocation"] as! String,
                                                       adImages: [],
                                                       imageLinks: data["imageURLs"] as? [String] ?? [],
                                                       datePosted: data["adPosted"] as! String,
                                                       isDraft: data["isDraft"] as! Bool,
                                                       bidCount: data["bidCount"] as? String ?? "Unavailable")
                        
                        pageContent.append(instance)
                        
                    }
                    
                    self.content = pageContent
                    
                }
            }
        }
    }
    
    
    func increaseBid(forAd adSummary: AuctionSaleData, editValue: String, bidCount: String){
        
        let bidReference = self.db.collection("LiveDatabase").document("adNo__\(adSummary.adId)")
        
        bidReference.updateData([
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
