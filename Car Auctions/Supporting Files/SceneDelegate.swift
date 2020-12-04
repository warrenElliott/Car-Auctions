//
//  SceneDelegate.swift
//  Car Auctions
//
//  Created by Warren Elliott on 17/06/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @State var isNavigationBarHidden : Bool = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = LogInView()
        let tabBarView = TabBarView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            window.rootViewController = UIHostingController(rootView: contentView)

            if (UserDefaults.standard.value(forKey: "userEmail") as? String) == nil{

                window.rootViewController = UIHostingController(rootView: contentView)

            }

            else{

                window.rootViewController = UIHostingController(rootView: tabBarView)

            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

