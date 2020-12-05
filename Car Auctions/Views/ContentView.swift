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

struct ContentView: View{
        
    @Binding var pageTitle: Text
    @Binding var emptyListMessage: String
    @Binding var isShowingDrafts: Bool
    @Binding var isNavigationBarHidden: Bool
    @Binding var query: Query
    @State var navBarMode: Bool = false
        
    var body: some View {
        
        NavigationView{
            
            NavigationContentView(pageTitle: self.$pageTitle, emptyListMessage: self.$emptyListMessage, isShowingDrafts: self.$isShowingDrafts, isNavigationBarHidden: self.$isNavigationBarHidden, query: self.$query, dispInLine: self.$navBarMode)
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            NavigationContentView(pageTitle: .constant(Text("test")), emptyListMessage: .constant("test"), isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false), query: .constant(Firestore.firestore().collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(Date()))), dispInLine: .constant(false))
            
        }

    }
}
