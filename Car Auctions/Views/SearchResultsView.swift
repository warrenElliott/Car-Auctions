//
//  ActionView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 20/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct SearchResultsView: View {
    
    @State private var adViewActive: Bool = false //state for ad preview
    @State private var emptyListMessage = "Nothing found!"
    
    let db = Firestore.firestore() 
    let currentDate = Date()
    
    @Binding var isNavigationBarHidden: Bool
    @Binding var searchText: String
    
    let query = FirebaseQueries()
    
    var body: some View {
        
        ZStack {
            
            Colours().bgColour
            
            VStack{
                
                RowView(emptyListMessage: self.$emptyListMessage, query: .constant(query.fetchSearchResults(text: self.searchText)), isShowingDraft: .constant(false))
                
            }
        }
        .navigationBarTitle("Search Results", displayMode: .inline)
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}


struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(isNavigationBarHidden: .constant(true), searchText: .constant("Test"))
    }
}

//view not updating
//another test this is another test 
