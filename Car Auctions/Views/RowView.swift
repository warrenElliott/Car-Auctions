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

struct RowView: View {

    @ObservedObject var loadContent = ContentLoader()
    @Binding var emptyListMessage: String
    @Binding var query: Query
    @Binding var isShowingDraft: Bool
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack{

                if loadContent.content.count > 0{
                    
                    List {
                        
                        ForEach(loadContent.content, id:\ .self) { item in

                                
                            NavigationLink(destination: (self.isShowingDraft ? AnyView(SellPageView(ad: item)) : AnyView(AdDetailView(adPreview: item)))){
                                    
                                    AuctionSale(sale: item, bidStatus: statusChecker(item: item))
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowInsets(EdgeInsets())
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .frame(width: geometry.size.width, alignment: .trailing)
                                
                            

                        }
                        
                    }.listStyle(PlainListStyle())
                    
                }
                
                else{
                    
                    Text(self.emptyListMessage)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                }

            }
            .onAppear(){
                
                self.loadContent.fetchData(dataQuery: self.query)

            }
        }
    }
    
    func statusChecker (item: AuctionSaleData) -> Int{
        
        var output = Int()
        
        for entry in item.bidHistory{
            
            if item.bidHistory.last?.bidder == UserDefaults.standard.value(forKey: "userEmail") as! String{
                return 1
            }
            
            else if item.bidHistory.last?.bidder != UserDefaults.standard.value(forKey: "userEmail") as! String{
                return 2
            }
            
            else{
                
                
                if entry.bidder != UserDefaults.standard.value(forKey: "userEmail") as! String{
                    
                    output = 3
                    
                }
                
            }
            
        }
        
        return output
    }
}
