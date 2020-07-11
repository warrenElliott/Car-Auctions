//
//  AdDetailView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 03/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct AdDetailView: View{
    
    @Binding var adPreview : AuctionSaleData
    @State var isActive = true
    @State var isShowingPlaceBidButton = true
    @State var showPublishAlert = false
    @State var index = 0
    
    @State var nowDate = Date()
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
    
        ZStack{

            Colours().carribeanGreen.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                
                ScrollView(){
                    
                    VStack(spacing: 0){
                        
                        if self.adPreview.adImages == []{
                            
                            Image("StockAdPhoto")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: 250)
                                .clipped()
                            
                        }else{
                            PagingView(index: $index.animation(), maxIndex: adPreview.adImages.count - 1) {
                                ForEach(self.adPreview.adImages.indices, id: \.self) { imageName in
                                    Image(uiImage: self.adPreview.adImages[imageName]!)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                        }
                        
                        HStack(spacing: 40){
                            VStack(alignment: .leading){
                                Text("Bid Closes In")
                                    .foregroundColor(.white)
                                
                                Text(TimeManager().countDownDate(self.adPreview.adEnding, self.nowDate))
                                    .bold()
                                    .foregroundColor(.white)
                                    .onAppear(perform: {
                                        self.timer
                                    })

                                
                            }
                            
                            
                            VStack(alignment: .leading){
                                Text("Current Bid")
                                    .foregroundColor(.white)
                                
                                Text("£ \(self.adPreview.adBid)")
                                    .bold()
                                    .foregroundColor(.white)
                                
                            }
                            
                            VStack(alignment: .leading){
                                Text("Total Bids")
                                    .foregroundColor(.white)
                                
                                Text("0")
                                    .bold()
                                    .foregroundColor(.white)
                                
                            }
                            
                            
                        }.frame(width: UIScreen.main.bounds.width, height: 55, alignment: .center)
                            .background(Colours().grey)
                        
                        Spacer()
                        
                        HStack(spacing: 0){
                            
                            Button(action: {
                                self.isActive = true
                                print (print (self.$adPreview.adDescription))
                            }) {
                                Text("Ad Desciption")
                                    .frame(width: 150)
                                    .foregroundColor(isActive ? .white : .blue)
                                    .background(isActive ? Colours().grey : .white)
                                
                            }
                            
                            Button(action: {
                                self.isActive = false
                            }) {
                                Text("Bidding History")
                                    .frame(width: 150)
                                    .foregroundColor(isActive ? .blue : .white)
                                    .background(isActive ? .white : Colours().grey)
                            }
                            
                        }.padding(5)
                            .background(Colours().grey)
                            .cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        
                        
                        if isActive{
                            
                            
                            Text(self.adPreview.adName)
                                .bold()
                                .padding()
                            
                            Text(self.adPreview.adDescription)
                                .frame(width: 350, alignment: .leading)
                                .padding(.bottom)
                            
                            Divider()
                            
                            HStack{
                                Text("Location: ")
                                .bold()
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                                
                                
                                Text(self.adPreview.adLocation)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 2,alignment: .trailing)
                            }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            
                            Divider()
                            
                            HStack{
                                
                                VStack{
                                
                                Text("Seller: ")
                                .bold()
                                    
                                Text("Email")
                                    
                                }
                                .padding(.leading).frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                                
                                
                                Text(/*self.adPreview.adLocation*/ "More Info")
                                .padding().frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                                
                            }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            
                            Divider()
                            
                        }
                        else{
                            
                            Text("Bidding history will appear here").padding()
                            
                        }
                    }
                }
                
                VStack{
                    
                    if self.adPreview.isDraft == true{
                        Text("")
                    }
                    else{
                        Text("Place bid")
                            .padding()
                            .frame(width: 300)
                            .background(Colours().lightBlue1)
                        
                    }
                }
                
                Spacer()
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            

        }.navigationBarItems(leading:
            
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text ("Back")
                .foregroundColor(.black)
                .bold()
                    
            }
        }, trailing:
        HStack {
            
            if self.adPreview.isDraft == true{
                Button(action: {
                    
                    if (self.adPreview.adName == "" || self.adPreview.adLocation == ""){
                        self.showPublishAlert = true
                    }
                    else{
                        
                        self.adPreview.isDraft = false
                        self.adPreview.datePosted = TimeManager().dateToIsoString(Date())
                        AdManager().uploadAd(self.adPreview)
                        print(self.adPreview)
                        
                    }
                    
                }) {
                    Text("Publish")
                        
                        .foregroundColor(.black)
                        .bold()
                        .alert(isPresented: self.$showPublishAlert, content: {
                        Alert(title: Text("Error"), message: Text("Ad Title or Location cannot be empty"), dismissButton: .default(Text("Ok")))
                        
                    })
                }
            }

            })
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
}


struct AdDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SellPageView()
    }
}
