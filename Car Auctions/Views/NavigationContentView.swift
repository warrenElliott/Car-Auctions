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

struct NavigationContentView: View {
    
    @Binding var pageTitle: Text
    @Binding var emptyListMessage: String
    @Binding var isShowingDrafts: Bool
    @Binding var isNavigationBarHidden: Bool
    @Binding var query: Query
    @Binding var dispInLine: Bool
    
    var body: some View {
        
        ZStack {
            
            Colours().bgColour
            
            VStack{
                
                RowContent(
                    emptyListMessage: self.$emptyListMessage,
                    query: .constant(self.query), isShowingDraft: self.$isShowingDrafts)
                
            }
        }
        .navigationBarTitle(self.pageTitle, displayMode: dispInLine ? .inline : .large)
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}

//struct UserBidsView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let db = Firestore.firestore()
//
//        NavigationContentView(pageTitle: Text(verbatim: ""), query: .constant(db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: "")), isShowingDrafts: .constant(false), emptyListMessage: .constant("nothing found!"), isNavigationBarHidden: .constant(true))
//    }
//}
