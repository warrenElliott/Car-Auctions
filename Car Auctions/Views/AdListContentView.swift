//
//  AdListView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 21/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI


struct AdListContentView: View {
    
    @ObservedObject var loadContent: LoadContent
    @Binding var adViewActive: Bool
    @Binding var emptyListMessage: String
    @Binding var pageTitle: String
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                
                Text(self.pageTitle)
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 350, alignment: .bottomLeading)
                    .padding(.top, 25)
                    .padding(.bottom, -25)
                Divider()
                
                
                if loadContent.content.count > 0{
                    
                    ForEach (loadContent.content.indices, id: \.self){ i in
                        
                        VStack{
                            
                            NavigationLink(destination: AdDetailView(adPreview: self.$loadContent.content[i]), isActive: self.$adViewActive) {
                                Text("") //SwiftUI navigator to the ad preview page.
                            }
                            
                            AuctionSale(sale: self.loadContent.content[i])
                                .onTapGesture {
                                    self.adViewActive = true
                            }
                            Divider()
                        }
                        
                    }
                    
                }
                    
                else{
                    
                    Text(self.emptyListMessage)
                    
                }
                
            }
            
        }
    }
    
}
