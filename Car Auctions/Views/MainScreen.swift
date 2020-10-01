//
//  MainScreen.swift
//  Car Auctions
//
//  Created by Warren Elliott on 18/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import SwiftUI
import Firebase

struct MainScreen: View{
    
    @ObservedObject var loadContent = LoadContent()
    
    let db = Firestore.firestore()
    let currentDate = Date()
       
    var body: some View {
        
        ZStack{
            Colours().paleSpringBud.edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Ending Today")
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .bottomLeading)
                    .padding(.top, 25)
                    .padding(.bottom, -25)
                
                Divider()
                
                ScrollView{
                    
                    if loadContent.content.count > 0{
                        
                        ForEach (loadContent.content.indices, id: \.self){ i in
                            
                            VStack{
                        
                            AuctionSale(sale: self.loadContent.content[i])
                            Divider()
                                
                            }

                        }
                        
                    }
                    
                }
                
        }

        }.onAppear() {
            
            self.loadContent.fetchData(query: self.db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(self.currentDate)))
            
            
            
        }
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
