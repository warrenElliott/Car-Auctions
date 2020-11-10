//
//  BidHistoryData.swift
//  Car Auctions
//
//  Created by Warren Elliott on 10/11/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct BidHistoryData: Identifiable, Hashable{
    
    let id: String
    let bidValue: String
    let bidder: String
    
}
