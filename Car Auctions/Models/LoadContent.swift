//
//  LoadContent.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import Firebase

class LoadContent: ObservableObject{
    
    @Published var content = [AuctionSaleData]()
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func fetchData(query: Query){
        
        query.addSnapshotListener { (querySnapshot, error) in
            
            var pageContent = [AuctionSaleData]()

            if let e = error{

                print (e)

            }

            else{

                if let snapshotDocs = querySnapshot?.documents{

                    for doc in snapshotDocs{

                        let data = doc.data()
                        var imageURLs = [String]()
                        
                        let instance = AuctionSaleData(adId: data["adID"] as! String,
                                                       adName: data["adName"] as! String,
                                                       adDescription: data["adDescription"] as! String,
                                                       adBid: data["adBid"] as! String,
                                                       adEndingTime: data["adEndingTime"] as? String ?? "",
                                                       adEndingDate: data["adEndingDate"] as? String ?? "",
                                                       adAuthor: data["adAuthor"] as! String,
                                                       adLocation: data["adLocation"] as! String,
                                                       adImages: [UIImage()],
                                                       datePosted: data["adPosted"] as! String,
                                                       isDraft: data["isDraft"] as! Bool,
                                                       bidCount: data["bidCount"] as! Int)
                                                
                        let imageDataReference = self.db.collection("LiveDatabase").document("adNo__\(instance.adId)").collection("AdImages")
                        
                        imageDataReference.getDocuments { (query, error) in
                            
                            if let e = error{

                                print (e)

                            }
                            
                            else{
                                
                                if let adImageData = query?.documents{
                                    
                                    for entry in adImageData{
                                        
                                        if let link = entry.data()["URL"]{
                                            imageURLs.append(link as! String)
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            print (imageURLs.count)
                            print (imageURLs)
                            
                            
                            
                            
                            
                        }
            

                        pageContent.append(instance)
                    }
                    
                    self.content = pageContent
                    
                }
            }
        }
    }
    
    
}
