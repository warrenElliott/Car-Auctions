//
//  MyBidsView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 12/11/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//


import SwiftUI
import Firebase
import Combine

struct MyBidsView: View{
    
    @State private var adViewActive: Bool = false
    @State private var emptyListMessage = "You currently have no bids placed"
    @State private var pageTitle = "Featured"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                
//                    AdListContentView(adViewActive: self.$adViewActive, emptyListMessage: self.$emptyListMessage, query: .constant(self.db.collection("LiveDatabase").whereField(/*to implement*/))))
                }
            
        }
            .navigationBarTitle("My Bids")
            .navigationBarHidden(false)

        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct MyBidsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyBidsView()
        }
        
    }
}
