//
//  AdListView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 21/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import Combine

struct AdListContentView: View {
    
    @ObservedObject var loadContent = LoadContent()
    @Binding var adViewActive: Bool
    @Binding var emptyListMessage: String
    //@Binding var pageTitle: String
    @Binding var query: Query
    
    @State var chosenIndex: AuctionSaleData = AuctionSaleData(adId: "", adName: "", adDescription: "", adBid: "", adEndingTime: "", adEndingDate: "", adAuthor: "", adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0)
    
    @State var chosenRow: MutableSaleData = MutableSaleData(adId: "", adName: "", adDescription: "", adBid: "", adEndingTime: "", adEndingDate: "", adAuthor: "", adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0)
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                
                Divider()
                
                
                if loadContent.content != []{
                    
                    ForEach (loadContent.content, id: \.self){ i in
                        
                        VStack{
                            
                            AuctionSale(sale: i)
                                .onTapGesture {
                                    self.chosenIndex = i
                                    self.adViewActive = true
                                    
                                    chosenRow = MutableSaleData(adId: chosenIndex.adId, adName: chosenIndex.adName, adDescription: chosenIndex.adDescription, adBid: chosenIndex.adBid, adEndingTime: chosenIndex.adEndingTime, adEndingDate: chosenIndex.adEndingDate, adAuthor: chosenIndex.adAuthor, adLocation: chosenIndex.adLocation, adImages: chosenIndex.adImages, imageLinks: chosenIndex.imageLinks, datePosted: chosenIndex.datePosted, isDraft: chosenIndex.isDraft, bidCount: chosenIndex.bidCount)
                                    
                            }
                            
                            NavigationLink(destination: MutableAdDetailView(mutableAdPreview: self.chosenRow), isActive: self.$adViewActive) {
                                Text("") //SwiftUI navigator to the ad preview page.
                            }
                            
                            Divider()
                        }
                        
                    }
                    
                }
                    
                else{
                    
                    Text(self.emptyListMessage)
                    
                }
                
            }
                
            }.onAppear(){
            
                self.loadContent.fetchData(dataQuery: self.query)
                
                
            
        }
    }
    
}

//                Text(self.pageTitle)
//                    .font(.custom("Arial", size: 40))
//                    .bold()
//                    .foregroundColor(.black)
//                    .frame(width: 350, alignment: .bottomLeading)
//                    .padding(.top, 25)
//                    .padding(.bottom, 25)
