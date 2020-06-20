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
                        }, label: {Image(systemName: "plus")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        })
                            .sheet(isPresented: $isShowingImagePicker, content: {
                                ImagePick(isPresented: self.$isShowingImagePicker)
                                
                            })
                            
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                                        
                    Image(uiImage: UIImage())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                    
                    Image(uiImage: UIImage())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                    
                }.offset(x: -4, y: -110)
                

                
                HStack{
                    
                    Image(uiImage: UIImage())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                    
                    Image(uiImage: UIImage())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                    
                    Image(uiImage: UIImage())
                        .frame(width: 100, height: 100)
                        .border(Color.black, width: 1)
                    
                }.offset(x: 0, y: 0)
                
                
                
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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var isPresented: Bool
    
    public typealias UIViewControllerType = ImagePickerController
    
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
        
        private let parent: ImagePick
        
        public init(_ parent: ImagePick) {
            self.parent = parent
        }

        func imagePicker(_ imagePicker: ImagePickerController, didSelectAsset asset: PHAsset) {
            

            
            print (asset.burstIdentifier as Any)
            
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, info) in
                print ("Selected")
            }
            
        }

        func imagePicker(_ imagePicker: ImagePickerController, didDeselectAsset asset: PHAsset) {
            print ("Selected")

        }

        func imagePicker(_ imagePicker: ImagePickerController, didFinishWithAssets assets: [PHAsset]) {
            print ("Selected")

        }

        func imagePicker(_ imagePicker: ImagePickerController, didCancelWithAssets assets: [PHAsset]) {

        }

        func imagePicker(_ imagePicker: ImagePickerController, didReachSelectionLimit count: Int) {
            
            print ("too many here")

        }
    }
        
    func updateUIViewController(_ uiViewController: ImagePick.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePick>) {
        
    }
    
}

