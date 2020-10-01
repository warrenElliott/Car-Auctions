//
//  AuctionSale.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct AuctionSale: View{
    
    var sale: AuctionSaleData
    
    @State var nowDate = Date()
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
        
    }

    var body: some View {
        
        HStack {
            
            Image("pug") //When we get the sale type AuctionSaleData, no images are in the array...
                .resizable()
                .frame(width: 170, height: 120, alignment: .leading)
                .padding(.leading)
            
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
                
                //Text("Countdown")
                Text(TimeManager().countDownDate(date: sale.adEndingDate, time: sale.adEndingTime, nowDate))
                    .bold()
                    .frame(width: 170, alignment: .leading)
                    .font(.custom("Arial", size: 14))
                    .onAppear(perform: {
                        self.timer
                    })
                
            }.frame(width: 170, height: 110, alignment: .topLeading)

            Spacer()
            
        }.frame(maxWidth: .infinity)
            .onAppear {
                print (self.sale)
        }
        
       
    }
    
}

struct AuctionSale_Previews: PreviewProvider {
    static var previews: some View {
        AuctionSale(sale: saleData[0])
    }
}
