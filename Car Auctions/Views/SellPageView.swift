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
    @State var ad = AuctionSaleViewModel(adId: "", adName: "", adDescription: "", adBid: "", adTimeRemaining: "", adAuthor: "", adLocation: "", adImages: [])
    @State var isEditing = false
    @State var counter = 0
    
    
    var body: some View {
        
        ZStack{
            Color(red: 0.11, green: 0.82, blue: 0.63, opacity: 1.00).edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Sell Your Car")
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .bottomLeading)
                    .padding(.top, 25)
                    .padding(.bottom, -25)
                Divider()
                    
            
                ScrollView{
                    
                    VStack(alignment: .center){
                        
                        Text("List your car for Auction Sale Here")
                            .padding(10)
                            .frame(width: 350, alignment: .center)
                        
                        
                        Text ("1. Select up to 6 images in the order you wish them to appear")
                            .frame(width: 350, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(){
                                
                                Image(uiImage: UIImage())
                                Button(action: {
                                    self.isShowingImagePicker.toggle()
                                }, label: {Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                })
                                    .sheet(isPresented: $isShowingImagePicker, content: {
                                        ImagePick(isPresented: self.$isShowingImagePicker, ad: self.$ad)
                                    })
                                    .frame(width: 110, height: 110)
                                    .border(Color.black, width: 3)
                                
                                
                                ForEach (ad.adImages, id: \.self){ adImage in
                                    
                                    Image(uiImage: adImage!)
                                        
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 110)
                                        .border(Color.black, width: 3)
                                        .clipped()
                                    .overlay(
                                        Button(action: {
                                            self.ad.adImages.remove(at: self.counter)}, label: {
                                    Image(systemName: "minus.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.red)
                                    })
                                    .offset(x: 40, y: -40))
                                }

                                
                            }

                            }
                        
                        Text ("2. Your ad title").padding(.top)
                            .frame(width: 350, alignment: .leading)
                        
                        TextField("Enter an Ad Title", text: $ad.adName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 370, height: nil)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3))
                        
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                }
                
            }
            
        }.navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
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
        imagePicker.settings.theme.selectionStyle = .numbered
        
        imagePicker.imagePickerDelegate = context.coordinator
        
        return imagePicker
    }
    

    class Coordinator: NSObject, ImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        //@Binding var ad: AuctionSaleViewModel
        let parent: ImagePick
        
        public init(_ parent: ImagePick) {
            self.parent = parent
        }
        
        func imagePicker(_ imagePicker: ImagePickerController, didSelectAsset asset: PHAsset) {
            
            
            
        }

        func imagePicker(_ imagePicker: ImagePickerController, didDeselectAsset asset: PHAsset) {
            
            
            
        }

        func imagePicker(_ imagePicker: ImagePickerController, didFinishWithAssets assets: [PHAsset]) {
            
            self.parent.ad.adImages = []

            for asset in assets{

                self.parent.ad.adImages.append(phAssetToImageConverter(asset: asset))

            }
            
            print (self.parent.ad.adImages)
            
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
            
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            options.isNetworkAccessAllowed = true

            
            manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
                imageOutput = image ?? UIImage()
            }
            
            return imageOutput
    
        }
    }
        
    func updateUIViewController(_ uiViewController: ImagePick.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePick>) {

        
    }
    
}
