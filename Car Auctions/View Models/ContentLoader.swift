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

class ContentLoader: ObservableObject{
    
    let db = Firestore.firestore() //reference to the database
    let storage = Storage.storage() //reference to the storage
    
    @Published var content = [AuctionSaleData]()
    @Published var history = [BidHistoryData]()
    
    func fetchData(dataQuery: Query){
        
        dataQuery.addSnapshotListener { (querySnapshot, error) in
              
            if let e = error{
                
                print (e.localizedDescription)
                
            }
            
            else{
                
                var pageContent = [AuctionSaleData]()
                var queryAdHistory = [BidHistoryData]()
                
                if let snapshotDocs = querySnapshot?.documents{
                    
                    for doc in snapshotDocs{
                        
                        var output = [BidHistoryData]()
                        let data = doc.data()
                        let adID = data["adID"] as! String
                        var adBidHistory = data["bids"] as? [[String: Any]]
                        
                        
                        for instance in adBidHistory ?? []{ // returning nil and crashign when uploading ad
                            
                            let instanceOutput = BidHistoryData(id: adID, bidValue: instance["bidValue"] as? String ?? "", bidder: instance["bidAuthor"] as? String ?? "")
                            
                            output.append(instanceOutput)
                            
                        }
                        
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
                                                       isDraft: data["isDraft"] as? Bool ?? false,
                                                       bidCount: data["bidCount"] as? String ?? "Unavailable",
                                                       bidHistory: output)

                        pageContent.append(instance)
                        
                    }
                    self.history = queryAdHistory
                    self.content = pageContent
                    
                }
            }
        }
    }
}
