//
//  AppDelegate.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinatorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Load Facebook core
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        loadCoordinator()
        
        var navigationBarAppearace = UINavigationBar.appearance()
        
        if let color = UIColor(named: "Primary") {
            navigationBarAppearace.tintColor = color
        }
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options:[UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // First, handle Facebook URL open request
        if let fbSDKAppId = Settings.appID, url.scheme!.hasPrefix("fb\(fbSDKAppId)"), url.host == "authorize" {
            let shouldOpen = ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            return shouldOpen
        }
        return true
    }
}

