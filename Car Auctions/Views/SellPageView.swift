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
import Firebase
import GooglePlaces

struct SellPageView: View{
    
    @State var isShowingImagePicker = false
    @State var isShowingSuggestions = false
    @State var ad = AuctionSaleData(adId: UUID().uuidString, adName: "", adDescription: "Enter your ad details here", adBid: "100", adEndingTime: "", adEndingDate: "", adAuthor: "" /*(UserDefaults.standard.value(forKey: "userEmail") as? String)!*/, adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0) //blank ad struct where the ad will be stored before being placed on the database
    @State var isEditing = false
    @State var counter = 6 //max images that can be uploaded
    @State var dateForAd = Date() //gives today's date
    @State var showAlert = false
    @State private var previewActive: Bool = false //state for ad preview
    
    
    var dateFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        let output = formatter.string(from: dateForAd)
        return output
    } //converts date to the selected format yyyy-mm-dd
    
    var timeFormatter: String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        let output = formatter.string(from: dateForAd)
        return output
        
    } //converts time to the selected format hhmmss
    
    var visualFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter
    } //how time remaining will be displayed
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack{
                Colours().paleSpringBud.edgesIgnoringSafeArea(.all)
                
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
                            
                            Text("Selling made easy")
                                .padding(.bottom)
                                .frame(width: 350, alignment: .center)
                            
                            
                            Text ("1. Select up to 6 images")
                                .frame(width: 350, alignment: .leading)
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(){ //shows uploaded images
                                    Image(uiImage: UIImage())
                                    Button(action: {
                                        if self.ad.adImages.count < 6{
                                            self.isShowingImagePicker.toggle() //toggles the state of the image picker (true if showing)
                                        }else{
                                            self.isShowingImagePicker = false //if the image count is greater than 5, don't allow to upload any more images
                                        }
                                    }, label: {Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.white)
                                    })
                                        .sheet(isPresented: $isShowingImagePicker, content: {
                                            ImagePick(isPresented: self.$isShowingImagePicker, ad: self.$ad, counter: self.$counter) //shows image picker Cocoapod
                                        })
                                        .frame(width: 110, height: 110)
                                        .border(Color.black, width: 3)
                                    
                                    
                                    ForEach (ad.adImages.indices, id: \.self){ i in // 'i' points to each image
                                        
                                        Image(uiImage: self.ad.adImages[i]!) //display uploaded images
                                            
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 110, height: 110)
                                            .border(Color.black, width: 1)
                                            .clipped()
                                            .overlay(
                                                Button(action: {
                                                    self.ad.adImages.remove(at: i) //remove where pointed
                                                    self.counter += 1 //when removed, increase the counter of pictures that can be uploaded by 1
                                                }, label: {
                                                    Image(systemName: "minus.circle.fill")
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(.red)
                                                })
                                                    .offset(x: 40, y: -40))
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            //form creator below
                            
                            Text ("2. Your ad title*").padding(.top)
                                .frame(width: 350, alignment: .leading)
                            
                            TextField("Enter an Ad Title", text: $ad.adName)
                                .background(Color.clear)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 370, height: nil)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3))
                            
                            Text ("3. Your ad description").padding(.top)
                                .frame(width: 350, alignment: .leading)
                            
                            TextView(text: $ad.adDescription) //custom textbox with multiple lines
                                .frame(width: 370, height: 140)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3))
                            
                            Text ("4. Your Starting Bid Price in GBP").padding(.top)
                                .frame(width: 350, alignment: .leading)
                            
                            HStack{
                                Text ("£")
                                TextField("", text: $ad.adBid)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 150, height: nil, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 3))
                                    .keyboardType(.decimalPad)
                            }.frame(width: 350, alignment: .leading)
                            
                            
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
                        VStack{
                            Text ("5. Your Ad Location")
                                .padding(.top)
                                .frame(width: 350, alignment: .leading)
                            
                            TextField("Enter your ad location here", text: $ad.adLocation)
                                .simultaneousGesture(TapGesture().onEnded {
                                    self.isShowingSuggestions.toggle()
                                })
                                .sheet(isPresented: $isShowingSuggestions, content: {
                                    PlacePicker(address: self.$ad.adLocation)
                                }) //place picker powered by Google API
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 370, height: nil)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3))
                            
                            Text ("6. Bid Ending")
                                .padding(.top)
                                .frame(width: 350, alignment: .leading)
                            
                            DatePicker("", selection: $dateForAd, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                .labelsHidden()
                            
                            Text ("Your auction will end on \(dateForAd, formatter: visualFormatter)")
                                .padding(.top)
                                .frame(width: 350, height: 60, alignment: .center)
                            
                            VStack{
                                
                                NavigationLink(destination: AdDetailView(adPreview: self.$ad), isActive: self.$previewActive) {
                                    Text("") //SwiftUI navigator to the ad preview page.
                                }
                                
                                Button(action: {
                                    
                                    self.ad.adEndingDate = TimeManager().dateToIsoString(self.dateForAd)
                                    self.ad.adEndingTime = TimeManager().timeToIsoString(self.dateForAd)
                                    self.previewActive = true //sets the timer for the ad and displays the preview by triggering the state of previewactive
                                    
                                }) {
                                    Text("Preview Ad")
                                        .frame(width: 300, alignment: .center)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                }.padding(.bottom)
                                
                                Button(action: {
                                    self.showAlert = true
                                }) {
                                    Text("Delete")
                                        .alert(isPresented: $showAlert, content: {
                                            Alert(title: Text("Permanently Delete Add?"), message: Text( "This action cannot be undone"), primaryButton: .default(Text("Got it!")){
                                                
                                                self.ad = AuctionSaleData(adId: "", adName: "", adDescription: "Enter your ad details here", adBid: "100", adEndingTime: "", adEndingDate: "", adAuthor: (UserDefaults.standard.value(forKey: "userEmail") as? String)!, adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0)
                                                
                                                self.dateForAd = Date()
                                                
                                                }, secondaryButton: .cancel())
                                            
                                        })
                                        
                                        .frame(width: 300, alignment: .center)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.96, green: 0.25, blue: 0.42, opacity: 1.0))
                                    
                                }
                                
                                Button(action: {
                                    
                                    self.ad.adEndingTime = self.dateFormatter
                                    self.ad.adEndingDate = self.timeFormatter
                                    AdManager().uploadAd(self.ad)
                                    
                                    self.ad = AuctionSaleData(adId: UUID().uuidString, adName: "", adDescription: "Enter your ad details here", adBid: "100", adEndingTime: "", adEndingDate: "", adAuthor: "" /*(UserDefaults.standard.value(forKey: "userEmail") as? String)!*/, adLocation: "", adImages: [], imageLinks: [], datePosted: "", isDraft: true, bidCount: 0)
                                    
                                }) {
                                    
                                    Text("Save to Drafts")
                                        .frame(width: 300, alignment: .center)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Colours().grey)
                                    
                                }.padding(.top)
                                
                            }.padding()
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
                    }
                }
                
            }.navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            
        }
    }
}

//MARK ----------------------------------------------------------------------------------------------------------

struct ImagePick: UIViewControllerRepresentable{

    public typealias UIViewControllerType = ImagePickerController
    
    @Binding var isPresented: Bool
    @Binding var ad: AuctionSaleData
    @Binding var counter: Int
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ImagePickerController {
        
        let imagePicker = ImagePickerController()

        imagePicker.settings.selection.max = counter
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

            for asset in assets{

                self.parent.ad.adImages.append(phAssetToImageConverter(asset: asset))
                self.parent.counter -= 1

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

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.textColor = .lightGray

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = nil
            textView.textColor = .black
        }

        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.text = textView.text
        }
        
    }
}


struct SellPageView_Previews: PreviewProvider {
    static var previews: some View {
        SellPageView()
    }
}


