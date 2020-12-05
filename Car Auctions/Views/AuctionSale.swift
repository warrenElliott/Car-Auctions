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
    
    @State var sale: AuctionSaleData
    @State var bidStatus: Int
    
    @State private var nowDate = Date()
    
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
                
                HStack{
                    
                    Text(
                        TimeManager().countDownDate(date: sale.adEndingDate, time: sale.adEndingTime, nowDate))
                        .bold()
                        .frame(maxWidth: 70, alignment: .leading)
                        .font(.custom("Arial", size: 14))
                        .onAppear(perform: {
                            self.timer
                        })
                    
                    Divider()
                        .padding(.leading, 30)
                    
                    if bidStatus == 1{
                        Text("Winning")
                            .bold()
                            .font(.custom("Arial", size: 14))
                            .frame(maxWidth: 70, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.green)
                    }
                    
                    if bidStatus == 2{
                        Text("Losing")
                            .bold()
                            .font(.custom("Arial", size: 14))
                            .frame(maxWidth: 70, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.red)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: 170, height: 110, alignment: .topLeading)
        }
    }
}

struct AuctionSale_Previews: PreviewProvider {
    static var previews: some View {
        AuctionSale(sale: saleData[0], bidStatus: 0)
    }
}
