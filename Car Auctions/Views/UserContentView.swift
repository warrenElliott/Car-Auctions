//
//  UserBidsView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 25/11/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct UserContentView: View {
    
    @State var pageTitle: Text
    @Binding var query: Query
    
    @State private var adViewActive: Bool = false //state for ad preview
    @State private var emptyListMessage = "Nothing found!"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        
        ZStack {
            
            Colours().bgColour
            
            VStack{
                Text("Test")
                
            }
        }
        .navigationBarTitle(self.pageTitle, displayMode: .inline)
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}

struct UserBidsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let db = Firestore.firestore()

        UserContentView(pageTitle: Text(verbatim: ""), query: .constant(db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: "")), isNavigationBarHidden: .constant(true))
    }
}
