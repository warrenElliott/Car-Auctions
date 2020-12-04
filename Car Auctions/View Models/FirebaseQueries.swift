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
    
    let endingToday = Firestore.firestore().collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(Date()))
    

    
    func fetchSearchResults(text: String) -> Query{
                        
        return Firestore.firestore().collection("LiveDatabase").whereField("adName", isEqualTo: text).whereField("adEndingDate", isGreaterThan: TimeManager().dateToIsoString(Date()))
        
    }
    
    
}

//test
