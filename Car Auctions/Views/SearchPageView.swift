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
    
    @State var pageTitle = "Search Results"
    @State var isNavigationBarHidden: Bool = false
    @ObservedObject var loadContent = LoadContent()
    @State private var adViewActive: Bool = false //state for ad preview false = not showing
    let db = Firestore.firestore()
    let currentDate = Date()
    
    @State var searchText = ""
    
    var body: some View {
        
        NavigationView{
        
            ZStack{
                
                Colours().bgColour
                
                if #available(iOS 14.0, *) {
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
                        
                        link(label: "", destination: SearchResultsView(isNavigationBarHidden: self.$isNavigationBarHidden, searchText: self.$searchText), state: self.$adViewActive)
                        
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
                    .navigationBarTitle("Search")
                    .navigationBarHidden(self.isNavigationBarHidden)
                }
                else {
                    // Fallback on earlier versions
                }
            }

        }
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


//                    Text("Search")
//                        .font(.custom("Arial", size: 40))
//                        .bold()
//                        .foregroundColor(.white)
//                        .frame(width: 350, alignment: .bottomLeading)
//                        .padding(.top, 25)
//                        .padding(.bottom, -25)

//            .onAppear {
//
//                self.isNavigationBarHidden = true
//
//            }
