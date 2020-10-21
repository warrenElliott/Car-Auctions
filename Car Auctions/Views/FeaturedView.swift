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
    
    @Binding var isNavBarHidden : Bool
    
    @ObservedObject var loadContent = LoadContent()
    @State private var adViewActive: Bool = false //state for ad preview
    @State private var emptyListMessage = "Hmm Nothing Ending Today...Tap on Search to find new auctions!"
    @State private var pageTitle = "Featured"
    
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        ZStack{
            
            Colours().white.edgesIgnoringSafeArea(.all)
            
            VStack{
                
                AdListContentView(loadContent: self.loadContent, adViewActive: self.$adViewActive, emptyListMessage: self.$emptyListMessage, pageTitle: self.$pageTitle)
                
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(isNavBarHidden)
            .navigationBarHidden(isNavBarHidden)
            
        }.onAppear() {
            
            self.loadContent.fetchData(dataQuery: self.db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(self.currentDate)))
            
            self.isNavBarHidden = true
            
        }
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView(isNavBarHidden: .constant(false))
        
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
