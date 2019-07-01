//
//  AppDelegate+Coordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension AppDelegate {
    internal func loadCoordinator() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController()
        self.appCoordinator = AppCoordinator(self.window?.rootViewController as! UINavigationController)
        self.appCoordinator?.start()
        self.window?.makeKeyAndVisible()
    }
}
