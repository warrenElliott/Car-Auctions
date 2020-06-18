//
//  MainScreen.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI

struct MainScreen: View{
       
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(red: 0.11, green: 0.82, blue: 0.63, opacity: 1.00).edgesIgnoringSafeArea(.all)
                Text("View Latest Car Auctions")
                .offset(x: 0, y: -270)
            }.navigationBarTitle("Car Auctions UK", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(red: 0.11, green: 0.82, blue: 0.63, alpha: 1.00)
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white,  NSAttributedString.Key.font: UIFont(name: "Arial", size: 30)!]
            })
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
    }
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
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
