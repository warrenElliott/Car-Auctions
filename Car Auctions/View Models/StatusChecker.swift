//
//  StatusChecker.swift
//  Car Auctions
//
//  Created by Warren Elliott on 04/12/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

struct StatusChecker{
    
    func statusCheck (item: AuctionSaleData) -> Int{
        
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
