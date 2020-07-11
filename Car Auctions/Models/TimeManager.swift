//
//  TimeToString.swift
//  Car Auctions
//
//  Created by Warren Elliott on 02/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

public class TimeManager{
    
    let formatter = DateFormatter()
    
    func dateToIsoString(_ date: Date) -> String{
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone.current
        let output = formatter.string(from: date)
        return output
        
    }
    
    func countDownDate(_ inputDate: String, _ nowdate: Date) -> String {

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //date format as stored in Firebase db
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //added current timezone
        let deadlineDate = formatter.date(from: inputDate) //according to date format your date string
        
        let calendar = Calendar.current
        let outputDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: nowdate, to: deadlineDate!)

        
        let dayText = String(describing: outputDateComponents.day!) + "d "
        let hourText = String(describing: outputDateComponents.hour!) + "h "
        let minuteText = String(describing: outputDateComponents.minute!) + "m "
        let secondsText = String(describing: outputDateComponents.second!) + "s "
        
        var output = String()
        
        if dayText == "0d "{
            
            output = hourText + minuteText
            return output
            
        }
        
        if dayText == "0d " && hourText == "0h "{
            
            output = minuteText + secondsText
            return output
            
        }
            
        if dayText == "0d " && hourText == "0h " && minuteText == "0m "{
            
            output = secondsText
            return output
            
        }
        
        else{
            
            output = dayText + hourText + minuteText
            return output
            
            
        }
        
        
        //output = dayText + hourText + String(describing: outputDateComponents.minute!) + "m " + String(describing: outputDateComponents.second!) + "s"
    }
    
    
}


