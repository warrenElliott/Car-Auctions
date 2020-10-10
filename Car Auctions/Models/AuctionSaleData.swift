//
//  AuctionSaleViewModel.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct AuctionSaleData{
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
