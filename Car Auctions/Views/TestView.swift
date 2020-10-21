//
//  ActionView.swift
//  Car Auctions
//
//  Created by Warren Elliott on 20/10/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import Foundation
import SwiftUI


struct TestView: View {
    @Binding var isNavigationBarHidden: Bool

    var body: some View {
        ZStack {
            Color.green
            //NavigationLink("View 3", destination: View3())
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}


struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(isNavigationBarHidden: .constant(true))
    }
}
