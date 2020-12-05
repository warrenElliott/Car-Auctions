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
        
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                    
                    RowContent(
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
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            RowContentView(query: Firestore.firestore().collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(Date())))
//        }
//
//    }
//}
