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
    @Published var history = [BidHistoryData]()
    
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
    
    func fetchBidHistory(adId: String){
        
        let ref = db.collection("LiveBidHistory").document("adNo__\(adId)").collection("bids").order(by: "timestamp")
        
        ref.addSnapshotListener { (querySnapshot, error) in
            
            if let e = error{
                
                print (e.localizedDescription)
                
            }
            
            else{
                
                var bidHistoryData = [BidHistoryData]()
                
                if let snapshotDocs = querySnapshot?.documents{
                    
                    for doc in snapshotDocs{
                        
                        let data = doc.data()
                        
                        var bidHistoryEntry = BidHistoryData(
                            id: data["bidID"] as! String,
                            bidValue: data["bidValue"] as! String,
                            bidder: data["bidder"] as! String)
                        
                        bidHistoryData.append(bidHistoryEntry)
                    }
                    
                    self.history = bidHistoryData
                    
                }
                
            }
            
        }

        
    }
}
