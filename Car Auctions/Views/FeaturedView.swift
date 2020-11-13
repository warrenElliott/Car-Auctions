//
//  MainScreen.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct FeaturedView: View{
    
    //@Binding var isNavBarHidden : Bool
    @State private var adViewActive: Bool = false //state for ad preview
    @State private var emptyListMessage = "Hmm Nothing Ending Today...Tap on Search to find new auctions!"
    @State private var pageTitle = "Featured"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Colours().bgColour
                
                VStack{
                    
                    Divider()
                
                    AdListContentView(adViewActive: self.$adViewActive, emptyListMessage: self.$emptyListMessage, query: .constant(self.db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(self.currentDate))))
                }
            
        }
            .navigationBarTitle("Featured")
            .navigationBarHidden(false)
            .onAppear() {

                print (UserDefaults.standard.value(forKey: "userEmail"))

            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedView()
        }
        
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
}
