//
//  ContentView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 17/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userEmail = ""
    @State private var userPassword = ""

    var body: some View {
        ZStack{
            
            //Color(red: 0.11, green: 0.82, blue: 0.63, opacity: 1.00).edgesIgnoringSafeArea(.all)
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
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 3))
                
                SecureField("Enter a password", text: $userPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: nil)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 3))
                
            }
            .offset(x: 0, y: -10)
            
            VStack(spacing: 10){
                
                Button(action: {print ("Hello")}) {
                    Text("Register")
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 40)
                        .background(Color.red)
                        .cornerRadius(15)
                }

                Button(action: {print ("Hello")}) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
