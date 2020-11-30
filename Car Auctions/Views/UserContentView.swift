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
    @Binding  var isShowingDrafts: Bool //state for ad preview
    @Binding var emptyListMessage: String
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        
        ZStack {
            
            Colours().bgColour
            
            VStack{
                
                AdListContentView(
                    emptyListMessage: self.$emptyListMessage,
                    query: .constant(self.query), isShowingDraft: self.$isShowingDrafts)
                
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

        UserContentView(pageTitle: Text(verbatim: ""), query: .constant(db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: "")), isShowingDrafts: .constant(false), emptyListMessage: .constant("nothing found!"), isNavigationBarHidden: .constant(true))
    }
}
