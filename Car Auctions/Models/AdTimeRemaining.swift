//
//  AdTimeRemaining.swift
//  Car Auctions
//
//  Created by Warren Elliott on 19/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

class TimeRemaining{
    
    func calculateTimeRemaining(time: Date) -> String{
        
        let date = Date()
        let iv = time.timeIntervalSince(date)
        
        return String(iv)
    }
    
}
