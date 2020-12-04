//
//  Favourites.swift
//  Car Auctions
//
//  Created by Warren Elliott on 01/12/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase


public class Favourites: ObservableObject{
    
    let db = Firestore.firestore()
    @ObservedObject var loadContent = ContentLoader()
    private let manageAd = AdManager()
    private let user = UserDefaults.standard.value(forKey: "userEmail") as! String
    private let destination = "Favourites"

    
    init(){
        
        loadContent.fetchData(dataQuery: self.db.collection("Users").document("\(user)").collection("\(destination)"))
        
    }
    
    func contains(_ ad: AuctionSaleData) -> Bool{
        
        var output = Bool()
        
        for s in self.loadContent.content{
            
            if s.adId == ad.adId{
                output = true
            }
            else{
                output = false
            }
            
        }
        return output
    }
    
    func add(_ ad: AuctionSaleData){
        
        manageAd.addToFavourites(forAd: ad, user: user)
        
    }
    
    func remove(_ ad: AuctionSaleData){
        
        manageAd.removeAdFromUserData(ad, user: user, destination: destination)
        
    }
    
    
}
