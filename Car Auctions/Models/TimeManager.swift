//
//  TimeToString.swift
//  Car Auctions
//
//  Created by Warren Elliott on 02/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

public class TimeManager{

    func stringToDate(_ dateString:String) -> Date{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let output = dateFormatter.date(from: dateString)!
        
        return output
        
    }
    
    func dateToIsoString(_ date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone.current
        let output = formatter.string(from: date)
        return output
        
    }
    
    
}


