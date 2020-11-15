//
//  AuctionSale.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
// test


import Foundation
import SwiftUI
import struct Kingfisher.KFImage
import UIKit

struct AuctionSale: View{
    
    @ObservedObject var loadContent = LoadContent()
    @State var sale: AuctionSaleData
    @State var nowDate = Date()
    @State var bidStatus = false
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date() //get current time and date and start timer
        }
        
    }
    
    var body: some View {
        
        HStack {
            
            if sale.imageLinks == []{
                
                Image("StockAdPhoto")
                    .resizable()
                    .frame(width: 170, height: 120, alignment: .leading)
                    .padding(.leading)
                
            }else{
                
                KFImage(URL(string: sale.imageLinks[0]!))
                    .resizable()
                    .frame(width: 170, height: 120, alignment: .leading)
                    .padding(.leading)
            }
            
            VStack(spacing: 5){
                
                HStack{
                    
                    Text(sale.adName)
                        .bold()
                        .font(.custom("Arial", size: 16))
                    
                    Spacer()
                    
                    Text("£"+sale.adBid)
                        .bold()
                        .font(.custom("Arial", size: 16))
                        .frame(alignment: .trailing)
                    
                }.frame(width: 170, alignment: .leading)
                
                
                Text(String(sale.adDescription))
                    .frame(width: 170, height: 50, alignment: .topLeading)
                    .font(.custom("Arial", size: 12))
                
                Text("Location: \((String(sale.adLocation)))")
                    .frame(width: 170, alignment: .topLeading)
                    .font(.custom("Arial", size: 12))
                
                
                Text(
                    TimeManager().countDownDate(date: sale.adEndingDate, time: sale.adEndingTime, nowDate))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Arial", size: 14))
                    .onAppear(perform: {
                        
                        self.timer
                        loadContent.fetchBidHistory(adId: sale.adId)
                        self.bidStatus = loadContent.bidWinningStatus(history: loadContent.history)
                       
                        if self.bidStatus == true{
                            print ("true")
                        }
                        else{
                            print (false)
                        }
                        
                        
                    })
                
            }
            .frame(width: 170, height: 110, alignment: .topLeading)
            
        }
           
            
        
    }
}

struct AuctionSale_Previews: PreviewProvider {
    static var previews: some View {
        AuctionSale(sale: saleData[0])
    }
}
