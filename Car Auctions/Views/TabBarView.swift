//
//  TabView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedView = 0
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            
            MainScreen()
                .tabItem {
                    Image(systemName: "car.fill")
                }.tag(0)
            
            Text("Fifth View")
                .tabItem{
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
            }.tag(1)
            
            SellPageView()
                .tabItem{
                    Image(systemName: "plus.circle.fill")
                    Text("Sell")
            }.tag(2)
            
            Text("Fourth View")
                .tabItem{
                    Image(systemName: "sterlingsign.circle.fill")
                    Text("My Bids")
            }.tag(3)

            Text("Second View")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("My Account")
            }.tag(4)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
