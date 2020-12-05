//
//  MainScreen.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct PageContentView: View{
    
    let bidStatus = StatusChecker()
    @ObservedObject var loadContent = ContentLoader()
    
    @Binding var pageTitle: String
    @Binding var emptyListMessage: String
    @Binding var isShowingDraft: Bool
    @State var query: Query
    //@State private var emptyListMessage = "Nothing Ending Today...Tap on Search to find other auctions!"
    //@State private var pageTitle = "Ending Today"
    
    let dbQuery = FirebaseQueries()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                    
                    GeometryReader{ geometry in
                        
                        ZStack{
                            
                            if loadContent.content.count > 0{
                                
                                List {
                                    
                                    ForEach(loadContent.content, id:\ .self) { item in
                                        
                                        
                                        NavigationLink(destination: (self.isShowingDraft ? AnyView(SellPageView(ad: item)) : AnyView(AdDetailView(adPreview: item)))){
                                            
                                            AuctionSale(sale: item, bidStatus: bidStatus.statusChecker(item: item))
                                            
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
            }
            .navigationBarTitle(self.pageTitle)
            .navigationBarHidden(false)
            //.navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            RowContentView(query: Firestore.firestore().collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(Date())))
//        }
//
//    }
//}
