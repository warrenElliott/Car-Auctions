//
//  PlaceBidView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 28/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct PlaceBidView: View{
    
    @Binding var show : Bool
    @Binding var adID: String
    @Binding var currentBid: String
    @State var editBidValue = 0
    @State var minusButtonDisabled = false
    
    var body: some View{
        
        ZStack{
            
            Color.white
                .opacity(0.9)

            VStack{
                
                HStack{
                    
                    Button(action: {
                        
                        if editBidValue == Int(currentBid){
                            minusButtonDisabled = true
                        }else{
                            editBidValue -= 25
                        }
                        
                        
                    }, label: {Image(systemName: "minus.circle")
                        .font(.system(size: 35))
                        .foregroundColor(.black)
                    }).disabled(self.minusButtonDisabled)
                    
                    Text("£" + String(editBidValue))
                        .font(.custom("Arial", size: 45))
                    
                    Button(action: {
                        
                        minusButtonDisabled = false
                        editBidValue += 25
                        
                    }, label: {Image(systemName: "plus.circle")
                        .font(.system(size: 35))
                        .foregroundColor(.black)
                    })
                    
                }.frame(width: 250, height: 60, alignment: .top)
                .onAppear(){
                    
                    editBidValue = Int(currentBid)!
                    
                }
                
                Text("Bid Must be in £25 increments")
                    .font(.system(size: 11))
                
                Spacer()
                
                Button(action: {
                    
                    AdManager().increaseBid(adID, editValue: String(editBidValue))

                    
                }, label: {
                    
                    Text("Place Bid")
                        .font(.custom("Arial", size: 20))
                        .frame(width: 90, height: 10, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Colours().carribeanGreen)
                        .cornerRadius(15)
                })
                
                Button(action: {
                    
                    show.toggle()
                    
                }, label: {
                    
                    Text("Cancel")
                        .font(.custom("Arial", size: 20))
                        .frame(width: 90, height: 10, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(15)
                })

            }.frame(width: 210, height: 110, alignment: .center)
            
        }.frame(width: 300, height: 190)
        .offset(y: show ? 0 : UIScreen.main.bounds.size.width)
        .animation(.default)

    }

}

struct PlaceBidView_Previews: PreviewProvider {
    static var previews: some View {
        
        PlaceBidView(show: .constant(true), adID: .constant("f"), currentBid: .constant("5000"))
        
    }
}