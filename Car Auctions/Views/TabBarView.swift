//
//  TabView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedView = 1
    @ObservedObject var loadContent = LoadContent()
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            MainScreen()
                .tabItem {
                    Image(systemName: "car.fill")
                }.tag(0)
            
            SearchPageView()
                .tabItem{
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
            }.tag(1)
            
            SellPageView()
                .tabItem{
                    Image(systemName: "plus.circle.fill")
                    Text("Sell")
            }.tag(2)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
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
        }.navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        

    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

func tabBarTitle(_ tag: Int) -> String{
    
    var outputTitle = String()
    
    switch tag{
        
    case 0:
        outputTitle = "Ending Soon"
    case 1:
        outputTitle = "Search"
    case 2:
        outputTitle = "List your car"
    case 3:
        outputTitle = "My Bids"
    case 4:
        outputTitle = "My Account"
    default:
        outputTitle = "Car Auctions UK"
    
        
    }
    
    return outputTitle
    
}
