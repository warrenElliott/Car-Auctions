//
//  AuctionSaleViewModel.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct AuctionSaleData: Hashable{
    
    var adId: String
    var adName: String
    var adDescription: String
    var adBid: String
    var adEndingTime: String
    var adEndingDate: String
    var adAuthor: String
    var adLocation: String
    var adImages: [UIImage?];
    var imageLinks: [String?];
    var datePosted: String
    var isDraft: Bool
    var bidCount: Int

}

//class AuctionSaleData: Hashable, ObservableObject{
//
//    @Published var adId: String
//    @Published var adName: String
//    @Published var adDescription: String
//    @Published var adBid: String
//    @Published var adEndingTime: String
//    @Published var adEndingDate: String
//    @Published var adAuthor: String
//    @Published var adLocation: String
//    @Published var adImages: [UIImage?];
//    @Published var imageLinks: [String?];
//    @Published var datePosted: String
//    @Published var isDraft: Bool
//    @Published var bidCount: Int
//
//    init(adId: String, adName: String, adDescription: String, adBid: String, adEndingTime: String, adEndingDate: String,
//         adAuthor: String, adLocation: String, adImages: [UIImage?], imageLinks: [String?], datePosted: String, isDraft: Bool, bidCount: Int){
//
//        self.adId = adId
//        self.adName = adName
//        self.adDescription = adDescription
//        self.adBid = adBid
//        self.adEndingTime = adEndingTime
//        self.adEndingDate = adEndingDate
//        self.adAuthor = adAuthor
//        self.adLocation = adLocation
//        self.adImages = adImages
//        self.imageLinks = imageLinks
//        self.datePosted = datePosted
//        self.isDraft = isDraft
//        self.bidCount = bidCount
//
//    }
//
//}
