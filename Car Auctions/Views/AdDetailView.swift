//
//  AdDetailView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 03/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct AdDetailView: View{
    
    @Binding var adPreview : AuctionSaleViewModel
    @State var isActive = true
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
    
        ZStack{

            Colours().carribeanGreen.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                Image("pug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .center)
                    .clipped()
                
                HStack(spacing: 40){
                    VStack(alignment: .leading){
                        Text("Bid Closes In")
                            .foregroundColor(.white)
                            
                        
                        Text("13d 15h")
                        .bold()
                        .foregroundColor(.white)
                        
                    }
                        
                    
                    VStack(alignment: .leading){
                        Text("Current Bid")
                        .foregroundColor(.white)
                        
                        Text("£300")
                        .bold()
                        .foregroundColor(.white)
                        
                    }
                    
                    VStack(alignment: .leading){
                        Text("Total Bids")
                        .foregroundColor(.white)
                        
                        Text("28")
                        .bold()
                        .foregroundColor(.white)
                        
                    }
                    
                    
                }.frame(width: UIScreen.main.bounds.width, height: 55, alignment: .center)
                    .background(Colours().grey)
                
                Spacer()
                
                HStack(spacing: 0){
                    
                    Button(action: {
                        self.isActive = true
                        print (print (self.$adPreview.adDescription))
                    }) {
                        Text("Ad Desciption")
                            .frame(width: 150)
                            .foregroundColor(isActive ? .white : .blue)
                            .background(isActive ? Colours().grey : .white)
                            
                    }
                    
                    Button(action: {
                        self.isActive = false
                    }) {
                        Text("Bidding History")
                        .frame(width: 150)
                            .foregroundColor(isActive ? .blue : .white)
                            .background(isActive ? .white : Colours().grey)
                    }
                    
                }.padding(5)
                    .background(Colours().grey)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    
                
                if isActive{
                    ScrollView{
                        
                        Text("Ad Title Goes Here")
                        .bold()
                        .padding()
                        
                    }
                }
                else{
                    ScrollView{
                        Text("yikies").padding()
                    }
                }
                
                VStack{
                    
                    Text("Place bid").padding()
                    
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            

        }.navigationBarItems(leading:
            
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text ("Back")
                    .background(Colours().carribeanGreen)
            }
        }, trailing:
        HStack {
            Button(action: {}) {
                Text("Publish")
            }
        })
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
}


struct AdDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SellPageView()
    }
}
