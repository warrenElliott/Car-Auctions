//
//  SearchPageView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 24/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//


import SwiftUI

struct SearchPageView: View{
    
    @State var searchText = ""
    
    var body: some View {
        
        ZStack{
            Colours().carribeanGreen.edgesIgnoringSafeArea(.all)
            
            VStack{
                 Text("Search")
                     .font(.custom("Arial", size: 40))
                     .bold()
                     .foregroundColor(.white)
                     .frame(width: 350, alignment: .bottomLeading)
                     .padding(.top, 25)
                     .padding(.bottom, -25)
                 
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
                
                Button(action: {
                    }) {
                    Text("Search")
                    .frame(width: 300, alignment: .center)
                    .padding()
                    .foregroundColor(.white)
                        .background(Color(red: 0.96, green: 0.25, blue: 0.42, opacity: 1.0))
                        
                }
                
            

                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
