//
//  AdListView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 21/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI


struct AdListView: View {
    
    @ObservedObject var loadContent: LoadContent
    @Binding var adViewActive: Bool
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                
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
                    
                    Text("Nothing found!")
                    
                }
                
            }
            
        }
    }
    
}
