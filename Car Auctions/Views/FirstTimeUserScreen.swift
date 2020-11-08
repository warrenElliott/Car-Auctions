//
//  ContentView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 17/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var signInSuccess: Bool = false
    
    init() { //editing the view of the navigation view bars for the app
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        appearance.backgroundColor = Colours().headerColor
        
        //apply the customisation across the app
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        
        UITableView.appearance().backgroundColor = Colours().backgroundColor
        UITableView.appearance().separatorStyle = .none
        
    }
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                GeometryReader { geo in
                    Image("bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        
                }.edgesIgnoringSafeArea(.all)
                
                VStack{
                    VStack(spacing: 10){
                        Text("Car Auctions")
                            .font(.custom("Roboto-Bold", size: 45))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Car auctions across the country in one app")
                            .font(.custom("Roboto-Regular", size: 14))
                            .foregroundColor(.white)
                        
                    }.padding(.bottom)
                    
                    VStack(spacing: 10){
                        
                        TextField("Email Address", text: $userEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: nil)
                            //.cornerRadius(5)
                            .overlay(Rectangle()
                                        .stroke(Color.black, lineWidth: 1))
                        
                        SecureField("Enter a password", text: $userPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: nil)
                            //.cornerRadius(5)
                            .overlay(Rectangle()
                                        .stroke(Color.black, lineWidth: 1))
                        
                    }
                    
                    VStack(spacing: 10){
                        
                        link(label: "", destination: TabBarView(), state: self.$signInSuccess)
                            .navigationBarTitle("")
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                        
                        
                        Button(action: {
                            self.registerUser(email: self.userEmail, password: self.userPassword);
                            StoreUserDetails.save(self.userEmail, self.userPassword)
                        }) {
                            Text("Register")
                                .foregroundColor(Color.white)
                                .frame(width: 280, height: 40)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        
                        Button(action: {
                            self.signInUser(email: self.userEmail, password: self.userPassword);
                            StoreUserDetails.save(self.userEmail, self.userPassword)
                        }) {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .frame(width: 280, height: 40)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        
                        Button(action: {
                            //needs implementation
                        }) {
                            Text("Forgot password?")
                                .underline()
                                .foregroundColor(Color.white)
                                .frame(width: 280, height: 40)
                        }
                        
                        
                    }
                    
                }.frame(width: 380, height: 500, alignment: .center)
            }
        }
        
    }
    
    private func link<Destination: View>(label: String, destination: Destination, state: Binding<Bool>) -> some View {
        return NavigationLink(destination: destination, isActive: state, label: {
            HStack {
                Text(label)
                
            }
        })
    }
    
    
}//struct

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
                        self.signInSuccess = true
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
                        self.signInSuccess = true
                    }
                }
            }
            
            else{
                print("Enter a valid email")
            }
            
        }
    }
    
}
