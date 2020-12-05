//
//  FirebaseQueries.swift
//  Car Auctions
//
//  Created by Warren Elliott on 03/12/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase

struct FirebaseQueries{
    
    private let db = Firestore.firestore()
    //var user = UserDefaults.standard.value(forKey: "userEmail") as! String
    
    func fetchEndingToday() -> Query{
        
        return db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(Date()))
        
    }
    
    func fetchUserBids() -> Query{
        
        return db.collection("Users").document("\(UserDefaults.standard.value(forKey: "userEmail") as! String)").collection("UserBids")
        
    }
        
    func fetchSearchResults(text: String) -> Query{
                        
        return db.collection("LiveDatabase").whereField("adName", isEqualTo: text).whereField("adEndingDate", isGreaterThan: TimeManager().dateToIsoString(Date()))
        
    }
    
    func fetchDrafts() -> Query{
        
        return db.collection("DraftsDatabase").whereField("adAuthor", isEqualTo: UserDefaults.standard.value(forKey: "userEmail") as! String)
        
    }
    
    func fetchFavourites() -> Query{
        
        return db.collection("Users").document("\(UserDefaults.standard.value(forKey: "userEmail") as! String)").collection("Favourites")
        
    }
    
    func fetchUserAds() -> Query{
        
        return db.collection("LiveDatabase").whereField("adAuthor", isEqualTo: UserDefaults.standard.value(forKey: "userEmail") as! String)
        
    }
    
}

//test
