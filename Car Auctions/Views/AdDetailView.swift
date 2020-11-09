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
    
    @State var adPreview : AuctionSaleData //data taken from the SellPageView form the user created
    
    @State var isActive = true //toggles between ad detail and bidding history subviews
    @State var isShowingPlaceBidButton = true
    @State var showPublishAlert = false
    @State var index = 0
    @State var nowDate = Date() //grabs actual time when user clicked on the ad to generate the timer
    
    @State var bidView = false
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
        
    }
    
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
    
        
        ZStack{

            Colours().bgColour.edgesIgnoringSafeArea(.all)
            
            PlaceBidView(show: self.$bidView, adPreview: $adPreview, currentBid: self.adPreview.adBid, bidCount: String(self.adPreview.bidCount)).zIndex(2)
            
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
                            
                            Text("Bidding history will appear here").padding()
                            
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
            
//            leading:
//            
//        HStack {
//            Button(action: {
//                //self.presentationMode.wrappedValue.dismiss()
//                
//                if self.adPreview.isDraft == false{
//                    
//                    self.adPreview = AuctionSaleData(adId: UUID().uuidString, adName: "", adDescription: "Enter your ad details here", adBid: "100", adEndingTime: "", adEndingDate: "", adAuthor: "" /*(UserDefaults.standard.value(forKey: "userEmail") as? String)!*/, adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0)
//                    
//                    //if the ad's been published, empty the binded ad struct which was created in SellPageView
//                }
//                
//            }) {
//                Text ("Back")
//                .foregroundColor(.black)
//                .bold()
//                    
//            }
//        },
                             
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

