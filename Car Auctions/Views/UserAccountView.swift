//
//  UserAccountView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 22/11/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct UserAccountView: View{
    
    @State private var adViewActive: Bool = false
    @State private var emptyListMessage = "You currently have no bids placed"
    @State private var pageTitle = "My Account"
    @State var user = UserDefaults.standard.value(forKey: "userEmail") as! String
    @State private var navBarMode: Bool = true
    
    let queries = FirebaseQueries()
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        NavigationView{
            
                ZStack{
                    
                    Colours().bgColour
                    
                    VStack{
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 20)
                            .padding(.top, 20)
                        Text(user)
                        //Text("email@email.com") //placeholder
                        
                        VStack{
                            
                            NavigationLink(destination: NavigationContentView(pageTitle: .constant(Text("My Drafts")), emptyListMessage: .constant("You have no drafts yet"), isShowingDrafts: .constant(true), isNavigationBarHidden: .constant(false), query: .constant(queries.fetchDrafts()), dispInLine: self.$navBarMode)){
                                Text("My Drafts")
                                    .listRowBackground(Color(Colours().backgroundColor))
                            }.frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                            Divider()
                            
                            NavigationLink(destination: NavigationContentView(pageTitle: .constant(Text("Watch List")), emptyListMessage: .constant("You are currently not watching ads"), isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false), query: .constant(queries.fetchFavourites()), dispInLine: self.$navBarMode)){
                                Text("Watch List")
                                    .listRowBackground(Color(Colours().backgroundColor))
                            }.frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                            Divider()
                            
                            NavigationLink(destination: NavigationContentView(pageTitle: .constant(Text("My Ads")), emptyListMessage: .constant("You currently do not have any live ads"), isShowingDrafts: .constant(false), isNavigationBarHidden: .constant(false), query: .constant(queries.fetchUserAds()), dispInLine: self.$navBarMode)){
                                Text("My Ads")
                                    .listRowBackground(Color(Colours().backgroundColor))
                            }.frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                            Divider()
                            
                        }.padding(.bottom, 10)
                        .padding(.top, 10)
                        .frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                        
                        Button(action: {
                        }) {
                            Text("Log out")
                                .foregroundColor(Color.white)
                                .frame(width: 280, height: 40)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        
                        Text("UK Car auctions - Version 1.0")
                            .padding(.top, 10)
                            .frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                            .font(.custom("Roboto", size: 15))
                        
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150, alignment: .top)
                }
                .navigationBarTitle(self.pageTitle)
                .navigationBarHidden(false)
                

        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserAccountView()
        }
        
    }
}
