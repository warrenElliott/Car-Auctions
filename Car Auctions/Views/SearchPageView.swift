//
//  SearchPageView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 24/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//


import SwiftUI
import Firebase
import Combine

struct SearchPageView: View{
    
    @State private var pageTitle = "Search"
    @State private var isNavigationBarHidden: Bool = false
    @State private var adViewActive: Bool = false //state for ad preview false = not showing
    @State private var navBarMode: Bool = true
    
    private let db = Firestore.firestore()
    private let currentDate = Date()
    
    @State var searchText = ""
    
    var body: some View {
        
        NavigationView{
        
            ZStack{
                
                Colours().bgColour
                
                    VStack{
                                                
                        Divider()
                        
                        Text ("Search for a particular car: e.g Audi A3")
                            .padding(.top)
                        
                        TextField("Search here", text: $searchText)
                            .background(Color.clear)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3))
                            .frame(width: 350, height: nil, alignment: .center)
                            .padding()
                                                
                        link(
                            label: "",
                            destination: NavigationContentView(pageTitle: .constant(Text("Search Results")), emptyListMessage: .constant("Nothing Found!"), isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false), query: .constant(FirebaseQueries().fetchSearchResults(text: self.searchText)), dispInLine: self.$navBarMode),
                            state: self.$adViewActive)
                        
                        Button(action: {
                            
                            self.adViewActive = true
                            
                        }) {
                            Text("Search")
                                .frame(width: 300, alignment: .center)
                                .padding()
                                .foregroundColor(.white)
                                .background(Colours().carribeanGreen)
                            
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .navigationBarTitle(self.pageTitle)
                    .navigationBarHidden(self.isNavigationBarHidden)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func link<Destination: View>(label: String, destination: Destination, state: Binding<Bool>) -> some View {
        return NavigationLink(destination: destination, isActive: state, label: {
                        HStack {
                Text(label)
            }
        })
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
