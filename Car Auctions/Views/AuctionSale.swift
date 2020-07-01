//
//  AuctionSale.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct AuctionSale: View{
    
    var sale: AuctionSaleViewModel

    var body: some View {
        HStack {
            Image(uiImage: sale.adImages[0]!)
                .resizable()
                .frame(width: 170, height: 120) as! Image
            VStack(spacing: 5){
                Text(sale.adName).bold()
                    
                Text("3 days, 4.32.16")
                Text("Bidding at: £" + sale.adBid)
            }.offset(x: 0, y: 0)
            
            Spacer()
        }
    }
    
}

struct AuctionSale_Previews: PreviewProvider {
    static var previews: some View {
        AuctionSale(sale: saleData[0])
    }
}
