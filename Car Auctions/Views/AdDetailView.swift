//
//  AdDetailView.swift
//  Car Auctions
//  Code for the Ad detail view where users find more information about the Ad.
//  Created by Warren Elliott on 03/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//
import Foundation
import SwiftUI
import UIKit
import struct Kingfisher.KFImage

struct AdDetailView: View{
    
    @ObservedObject var loadContent = ContentLoader()
    
    @State var adPreview: AuctionSaleData //data taken from the SellPageView form the user created
    @State var bidHistory = [BidHistoryData]()
    
    @State var isActive = true //toggles between ad detail and bidding history subviews
    @State var isShowingPlaceBidButton = true
    @State var showPublishAlert = false
    @State var index = 0
    @State var nowDate = Date() //grabs actual time when user clicked on the ad to generate the timer
    @State var bidView = false
    @State var notificationView = false
    @State var userFavourites = Favourites()
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
        
    }
    
    @ViewBuilder var body: some View {
        
        ZStack{

            Colours().bgColour.edgesIgnoringSafeArea(.all)
            
            PlaceBidView(show: self.$bidView, showNotification: self.$notificationView, adPreview: $adPreview, currentBid: self.adPreview.adBid, bidCount: String(self.adPreview.bidCount)).zIndex(1)
                
            BidSuccessPopUpView(show: self.$notificationView).zIndex(1)
                //.animation
            
            VStack(spacing: 0){
                
                ScrollView(){
                    
                    VStack(spacing: 0){
                        
                        if self.adPreview.adImages.count == 0 && self.adPreview.imageLinks.count == 0{
                            
                            Image("StockAdPhoto")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: 250)
                                .clipped()

                        }else{
                            
                            if self.adPreview.imageLinks.count > 0 && self.adPreview.adImages.count == 0{
                                
                                PagingView(index: $index.animation(), maxIndex: adPreview.imageLinks.count - 1) {
                                    
                                    ForEach(self.adPreview.imageLinks.indices, id: \.self) { link in
                                        KFImage(URL(string: self.adPreview.imageLinks[link]!))
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }.frame(width: UIScreen.main.bounds.width, height: 250)
                            }
                                
                            else{
                                
                                PagingView(index: $index.animation(), maxIndex: adPreview.adImages.count - 1) { //carousel images view with dots, where user swipes for the next pic
                                    ForEach(self.adPreview.adImages.indices, id: \.self) { imageName in
                                        Image(uiImage: self.adPreview.adImages[imageName]!)
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    
                                }.frame(width: UIScreen.main.bounds.width, height: 250)
                            }
                            
                        }
                        
                        HStack(spacing: 40){
                            VStack(alignment: .leading){
                                Text("Bid Closes In")
                                    .foregroundColor(.white)
                                
                                Text(TimeManager().countDownDate(date: self.adPreview.adEndingDate, time: self.adPreview.adEndingTime, nowDate))
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
                                
                                Text(self.adPreview.bidCount)
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
                            
                            if self.adPreview.bidHistory.count == 0{
                                Text("Bidding history will appear here").padding()
                            }
                            
                            else{
                                
                                HStack{
                                    
                                    Text("Bidder")
                                    .bold()
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                                    
                                    Text("Bid Value")
                                    .bold()
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width / 2,alignment: .trailing)
                                }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                    
                                
                                ForEach(self.adPreview.bidHistory, id:\ .self){ entry in
                                    
                                    HStack{
                                        Text(entry.bidder)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                                        
                                        
                                        Text(entry.bidValue)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width / 2,alignment: .trailing)
                                    }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                    
                                }
                            }
                        }
                    }
                }
                
                VStack{
                    
                    if self.adPreview.isDraft == true{
                        Text("")
                    }
                    else{
                        
                        Button(action: {
                            
                            self.bidView = true

                    
                        }, label: {Text("Place bid")
                            .padding()
                            .frame(width: 300)
                            .background(Colours().carribeanGreen)
                        })
                        
                    }
                }
                
                Spacer()
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)


        }.navigationBarItems(
                             
        trailing:
            
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
            
            else{
                    Button(action: {
                        self.userFavourites.contains(self.adPreview) ? self.userFavourites.remove(self.adPreview) : self.userFavourites.add(self.adPreview)
                    }) {
                        Text(self.userFavourites.contains(self.adPreview) ? "Unwatch" : "Watch")
                            .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                            .foregroundColor(.white)
                    }
            }
            })
        
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(false)

    }
}


struct AdDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SellPageView()
    }
}

