//
//  SellPageView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 20/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import BSImagePicker
import Photos

struct SellPageView: View{
    
    @State var isShowingImagePicker = false
    @State var ad = AuctionSaleViewModel(adId: "", adName: "", adDescription: "", adBid: "", adTimeRemaining: "", adAuthor: "", adLocation: "", adImages: [UIImage?](repeating: nil, count: 6))
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(red: 0.11, green: 0.82, blue: 0.63, opacity: 1.00).edgesIgnoringSafeArea(.all)
                Text("List your car for Auction Sale Here")
                    .offset(x: 0, y: -250)
                Text ("1. Select up to 6 images")
                    .offset(x: -80, y: -200)

                HStack{
                    
                    Image(uiImage: UIImage())
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                            print (self.ad)
                        }, label: {Image(systemName: "plus")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        })
                            .sheet(isPresented: $isShowingImagePicker, content: {
                                ImagePick(isPresented: self.$isShowingImagePicker, ad: self.$ad)
                            })
                    .frame(width: 100, height: 100)
                    .border(Color.black, width: 1)
                                     
                    Image(uiImage: ad.adImages[0] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()

                    
                    Image(uiImage: ad.adImages[1] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()
                    
                }.offset(x: -4, y: -110)
                
                HStack{
                    
                    Image(uiImage: ad.adImages[2] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()
                    
                    Image(uiImage: ad.adImages[3] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()
                    
                    Image(uiImage: ad.adImages[4] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()
                    
                }.offset(x: 0, y: 0)
                
                HStack{
                    Image(uiImage: ad.adImages[5] ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 3)
                        .clipped()
                }.offset(x: -80, y: 110)
                
                
                
            }.navigationBarTitle("Sell", displayMode: .inline)
                .navigationBarHidden(false)
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

struct SellPageView_Previews: PreviewProvider {
    static var previews: some View {
        SellPageView()
    }
}

struct ImagePick: UIViewControllerRepresentable{

    public typealias UIViewControllerType = ImagePickerController
    
    @Binding var isPresented: Bool
    @Binding var ad: AuctionSaleViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ImagePickerController {
        
        let imagePicker = ImagePickerController()

        imagePicker.settings.selection.max = 6
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = false
        
        imagePicker.imagePickerDelegate = context.coordinator
        
        return imagePicker
    }
    

    class Coordinator: NSObject, ImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        //@Binding var ad: AuctionSaleViewModel
        let parent: ImagePick
        public var adImages = [UIImage]()
        
        public init(_ parent: ImagePick) {
            self.parent = parent


        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didSelectAsset asset: PHAsset) {
            
            print ("Asset Selected")
            
        }

        func imagePicker(_ imagePicker: ImagePickerController, didDeselectAsset asset: PHAsset) {
            print ("Asset Deselected")

        }

        func imagePicker(_ imagePicker: ImagePickerController, didFinishWithAssets assets: [PHAsset]) {
            
            var counter = 0
            
            self.parent.ad.adImages = [UIImage?](repeating: nil, count: 6)
            
            for asset in assets{
                
                self.parent.ad.adImages[counter] = phAssetToImageConverter(asset: asset) ?? UIImage()
                
                counter += 1
                
            }
            
            self.parent.isPresented = false

        }

        func imagePicker(_ imagePicker: ImagePickerController, didCancelWithAssets assets: [PHAsset]) {
            
            print ("Session Cancelled")

        }

        func imagePicker(_ imagePicker: ImagePickerController, didReachSelectionLimit count: Int) {
            
            print ("Too much Selection Here")

        }
        
        func phAssetToImageConverter(asset: PHAsset) -> UIImage?{
            
            let manager = PHImageManager.default()
            var imageOutput = UIImage()
            
            manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil) { (image, info) in
                imageOutput = image ?? UIImage()
            }
            
            return imageOutput
    
        }
    }
        
    func updateUIViewController(_ uiViewController: ImagePick.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePick>) {

        
    }
    
}





