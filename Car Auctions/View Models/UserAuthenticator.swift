//
//  UserAuthorisation.swift
//  Car Auctions
//
//  Created by Warren Elliott on 02/12/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

public class UserAuthenticator{
        
    func registerUser(email: String, password: String) -> Bool{
                        
        if email == "" {
            print ("Enter a valid email")
        }
        if password == "" {
            print ("Enter a valid password")
        }
        else{
            if email.contains("@"){
                
                Auth.auth().createUser(withEmail: email, password: password)
                return true
                
            }
            else{
                
                print("Enter a valid email")
                
            }
            
        }
        return false
    }
    
    func signInUser(email: String, password: String) -> Bool{
                        
        if email == "" {
            print ("Enter a valid email")
        }
        if password == "" {
            print ("Enter a valid password")
        }
        else{
            if email.contains("@"){
                
                Auth.auth().signIn(withEmail: email, password: password)
                return true
                
            }
            else{
                
                print("Enter a valid email")
                
            }
            
        }
        return false
    }
}
