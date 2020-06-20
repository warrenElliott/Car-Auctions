//
//  ContentView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 17/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView{
            ZStack{
                
                Image("bg2").opacity(1)
                
                VStack(spacing: 10){
                    Text("Car Auctions UK")
                        .font(.custom("Hiragino Sans", size: 40))
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Car Auctions across the country in one app")
                        .font(.custom("Hiragino Sans", size: 12))
                }
                .offset(x: 0, y: -140)
                
                VStack(spacing: 10){
                    
                    TextField("eMail Address", text: $userEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: nil)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3))
                    
                    SecureField("Enter a password", text: $userPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: nil)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3))
                    
                }
                .offset(x: 0, y: -10)
                
                VStack(spacing: 10){
                    
                    NavigationLink(destination: TabBarView(), isActive: self.$isActive) {
                        Text("")
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    
                    Button(action: {
                        self.registerUser(email: self.userEmail, password: self.userPassword);
                    }) {
                        Text("Register")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40)
                            .background(Color.red)
                            .cornerRadius(15)
                    }

                    Button(action: {self.signInUser(email: self.userEmail, password: self.userPassword);}) {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40)
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    
                    
                }.offset(x: 0, y: 100)
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView{
    
    func registerUser(email: String, password: String){
        
        if email == "" {
    
            print ("Enter a valid email")
            
        }
        
        if password == "" {
            
            print ("Enter a valid password")
            
        }
        
        else{
            if email.contains("@"){
                Auth.auth().createUser(withEmail: self.userEmail, password: self.userPassword) { authResult, error in
                    if let e = error{
                        print (e.localizedDescription)
                    }
                    else{
                        self.isActive = true
                    }
                }
                
            }
            else{
                print("Enter a valid email")
            }
            
        }
    }
    
    func signInUser(email: String, password: String){
        
        if email == "" {
    
            print ("Enter a valid email")
            
        }
        
        if password == "" {
            
            print ("Enter a valid password")
            
        }
        
        else{
            if email.contains("@"){
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error{
                        print (e.localizedDescription)
                    }
                    else{
                        self.isActive = true
                    }
                }
            }
                
            else{
                print("Enter a valid email")
            }
            
        }
    }
    
}
