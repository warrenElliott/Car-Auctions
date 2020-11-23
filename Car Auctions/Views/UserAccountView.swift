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
    
    @State private var listContents = ["My Drafts", "Watch List", "My Ads", "Auctions Won", "Auctions Lost"] //create a struct for this
    
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
                        //Text(UserDefaults.standard.value(forKey: "userEmail") as! String)
                        Text("email@email.com") //placeholder
                        
                        VStack{
                            
                            
                            ForEach(listContents, id: \.self){ content in
                                
                                NavigationLink(destination: ContentView()){
                                    Text(content)
                                        .listRowBackground(Color(Colours().backgroundColor))
                                }
                                Divider()

                                
                            }.frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                        }.padding(.bottom, 10)
                        .padding(.top, 10)
                        
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
