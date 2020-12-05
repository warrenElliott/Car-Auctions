//
//  TabView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    let firebaseQueries = FirebaseQueries()
    
    @State var selectedView = 1 //initial View
    @State var navBarWillBeHidden = true 
    @State var pageTitle = "Featured"
    @ObservedObject var loadContent = ContentLoader()
        
    var body: some View {
            
            TabView(selection: $selectedView) {
                
                ContentView(
                    pageTitle: .constant(Text("Ending Today")),
                    emptyListMessage: .constant("Nothing Ending Today...Tap on Search to find other auctions!"),
                    isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false), query: .constant(firebaseQueries.fetchEndingToday()))
                    .tabItem {
                        Image(systemName: "car.fill")
                    }.tag(0)
                    .navigationBarTitle("Ending Today", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                
                SearchPageView()
                    .tabItem{
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                }.tag(1)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
        
                SellPageView()
                    .tabItem{
                        Image(systemName: "plus.circle.fill")
                        Text("Sell")
                }.tag(2)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                
                ContentView(
                    pageTitle: .constant(Text("My bids")),
                    emptyListMessage: .constant("You currently have no bids placed"),
                    isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false),  query: .constant(firebaseQueries.fetchUserBids()))
                    .tabItem {
                        Image(systemName: "sterlingsign.circle.fill")
                        Text("My Bids")
                    }.tag(3)
                    .navigationBarTitle("My bids", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                

                UserAccountView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Account")
                }.tag(4)
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
