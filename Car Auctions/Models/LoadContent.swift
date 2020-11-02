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
                        
                        let instance = AuctionSaleData(adId: adID,
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
                                                       bidCount: data["bidCount"] as! Int) //this creates a blank instance where data will be stored internally
                        
                        pageContent.append(instance)
                        
                    }
                    
                    self.content = pageContent
                    
                }
            }
        }
    }
}

//    func fetchImageURLs(id: String) -> [String]{
//
//        var pageURLs = [String]()
//
//        let imageDataReference = self.db.collection("LiveDatabase").document("adNo__\(id)").collection("AdImages") //tap into the above ad's image URLS here
//
//        imageDataReference.getDocuments { (query, error) in
//
//            if let e = error{
//
//                print (e.localizedDescription)
//
//            }
//
//            else{
//
//                if let adImageData = query?.documents{
//
//                    for entry in adImageData{
//
//                        if let link = entry.data()["URL"]{
//
//                            print (link)
//
//                            pageURLs.append(link as! String)
//
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//        }
//
//        return pageURLs
//    }
