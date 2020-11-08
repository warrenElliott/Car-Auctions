//
//  TabView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedView = 1 //init ial View
    @State var navBarWillBeHidden = true 
    @State var pageTitle = "Featured"
    @ObservedObject var loadContent = LoadContent()
    @State var isNavBarHidden = true
    
    var body: some View {
            
            TabView(selection: $selectedView) {
                
                FeaturedView(isNavBarHidden: $navBarWillBeHidden)
                    .tabItem {
                        Image(systemName: "car.fill")
                    }.tag(0)
                    .navigationBarTitle("Featured", displayMode: .inline)
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
                
                Text("Fourth View")
                    .tabItem{
                        Image(systemName: "sterlingsign.circle.fill")
                        Text("My Bids")
                }.tag(3)
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                
                
                
                Text("Second View")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Account")
                }.tag(4)
                    .navigationBarTitle("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                
            }
            .onAppear() {
                
                self.isNavBarHidden = true
                
            }

    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(isNavBarHidden: true)
    }
}
