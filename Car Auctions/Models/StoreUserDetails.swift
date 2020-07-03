//
//  StoreUserDetails.swift
//  Car Auctions
//
//  Created by Warren Elliott on 03/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation

public class StoreUserDetails{
    
    static func save(_ email: String, _ password: String){
        
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        
    }
    
}
