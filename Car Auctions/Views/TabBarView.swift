//
//  TabView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedView = 1 //initial View
    
    @State var navBarWillBeHidden = true // Result View's Tabbar visibility state
    @State var pageTitle = "Featured"
    
    @ObservedObject var loadContent = LoadContent()
    
    var body: some View {
        
        NavigationView{
            
            TabView(selection: $selectedView) {
                
                FeaturedView(isNavBarHidden: $navBarWillBeHidden)
                    .tabItem {
                        Image(systemName: "car.fill")
                }.tag(0)
//                    .navigationBarTitle("")
//                    .navigationBarBackButtonHidden(navBarWillBeHidden) //tab bar will be hidden when going into this view
//                    .navigationBarHidden(navBarWillBeHidden)
                
                
                
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
                    .navigationBarTitle("")
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
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        
        
        }
        
        
    }
}

//struct TabView_Previews: PreviewProvider {
//
//    var isNavigationBarHidden : Bool = true
//
//    static var previews: some View {
//
//        TabBarView(isNavigationBarHidden: self.$isNavigationBarHidden)
//
//    }
//}

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

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
