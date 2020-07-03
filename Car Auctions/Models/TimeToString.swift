//
//  TimeToString.swift
//  Car Auctions
//
//  Created by Warren Elliott on 02/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct StringToDate{
    
    func converter(_ dateString:String) -> Date{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let updatedAt = dateFormatter.date(from: dateString)!
        
        return updatedAt
        
    }
}


