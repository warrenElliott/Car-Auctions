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
    @Binding var pageTitle: String
    
    @ObservedObject var loadContent = LoadContent()
    @State private var adViewActive: Bool = false //state for ad preview
    let db = Firestore.firestore()
    let currentDate = Date()
    
    var body: some View {
        
        ZStack{
            
            Colours().white.edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Text(pageTitle)
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 350, alignment: .bottomLeading)
                    .padding(.top, 25)
                    .padding(.bottom, -25)
                Divider()
                
                ScrollView{
                    
                    if loadContent.content.count > 0{
                        
                        ForEach (loadContent.content.indices, id: \.self){ i in
                            
                            VStack{
                                
                                NavigationLink(destination: AdDetailView(adPreview: self.$loadContent.content[i]), isActive: self.$adViewActive) {
                                    Text("") //SwiftUI navigator to the ad preview page.
                                }
                                
                                AuctionSale(sale: self.loadContent.content[i])
                                    .onTapGesture {
                                        self.adViewActive = true
                                }
                                Divider()
                            }
                            
                        }
                        
                    }
                        
                    else{
                        
                        Text("Hmm Nothing Ending Today...Tap on Search to find new auctions!")
                        
                    }
                    
                }
                
            }
            .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(isNavBarHidden)
        .navigationBarHidden(isNavBarHidden)
            
        }.onAppear() {
            
            self.loadContent.fetchData(dataQuery: self.db.collection("LiveDatabase").whereField("adEndingDate", isEqualTo: TimeManager().dateToIsoString(self.currentDate)))
            
            self.isNavBarHidden = true
            
//            print (self.isNavBarHidden)
            
            
        }
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView(isNavBarHidden: .constant(false), pageTitle: .constant("TestPage"))
        
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
