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

struct UserBidsView: View{

    @State private var emptyListMessage = "You currently have no bids placed"
    @State private var pageTitle = "My bids"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                    
                    RowContent(
                        emptyListMessage: self.$emptyListMessage,
                        query: .constant(
                            self.db.collection("Users").document("\(UserDefaults.standard.value(forKey: "userEmail") as! String)").collection("UserBids")), isShowingDraft: .constant(false))
                    
                }
            }
            .navigationBarTitle(self.pageTitle)
            .navigationBarHidden(false)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct MyBidsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserBidsView()
        }
        
    }
}
