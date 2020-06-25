//
//  SearchPageView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 24/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//


import SwiftUI

struct SearchPageView: View{
    
    var body: some View {
        
        ZStack{
            Color(red: 0.11, green: 0.82, blue: 0.63, opacity: 1.00).edgesIgnoringSafeArea(.all)
            Text("Browse all auctions here")
                .offset(x: 0, y: -250)
        }
        
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
