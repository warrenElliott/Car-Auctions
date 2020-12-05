//
//  LocationTextField.swift
//  Car Auctions
//
//  Created by Warren Elliott on 15/07/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//
import Foundation
import SwiftUI
import UIKit
import GooglePlaces

struct SearchBar : UIViewRepresentable {

    @Binding var text : String

    class Cordinator : NSObject, UISearchBarDelegate {

        @Binding var text : String

        init(text : Binding<String>)
        {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar,
                       textDidChange searchText: String)
        {
            text = searchText
        }
    }

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }

    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>)
        -> UISearchBar {

            let searchBar = UISearchBar(frame: .zero)
            searchBar.delegate = context.coordinator
            return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct PlacePicker: UIViewControllerRepresentable { //replaces swiftUI with UIKit Components
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    } //creates coordinator and assigns to itself as this block executes Coordinator
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String //result and assigned
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator

        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .city
        filter.country = "UK"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

        var parent: PlacePicker

        init(_ parent: PlacePicker) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print(place.description.description as Any)
                self.parent.address =  place.name!
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
