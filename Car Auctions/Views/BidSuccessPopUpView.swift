//
//  BidSuccessPopUpView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 09/11/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI

struct BidSuccessPopUpView: View {
    
    @Binding var show : Bool
    
    var body: some View {
        
        ZStack{
            
            Colours().headerColorUI
            
            HStack(alignment: .lastTextBaseline){
                
                
                Text("Bid Placed!")
                    .font(.custom("Roboto", size: 20))
                    .foregroundColor(.white)
                    .frame(alignment: .topTrailing)
                    .padding(.trailing, 160)
                    .alignmentGuide(.lastTextBaseline, computeValue: { return $0[.top] + 25 })
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 100, alignment: .center)
        .offset(y: self.show ? UIScreen.main.bounds.height/3.1 : UIScreen.main.bounds.height)
        .animation(.easeInOut)
        
        
    }
}

struct BidSuccessPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        BidSuccessPopUpView(show: .constant(true))
    }
}
