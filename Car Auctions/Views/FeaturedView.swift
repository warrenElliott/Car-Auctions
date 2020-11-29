//
//  MainScreen.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct FeaturedView: View{
    
    @State private var emptyListMessage = "Nothing Ending Today...Tap on Search to find other auctions!"
    @State private var pageTitle = "Ending Today"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                
                    AdListContentView(emptyListMessage: self.$emptyListMessage, query: .constant(self.db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(self.currentDate))))
                }
        }
            .navigationBarTitle(self.pageTitle)
            .navigationBarHidden(false)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedView()
        }
        
    }
}
