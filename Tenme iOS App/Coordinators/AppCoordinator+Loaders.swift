//
//  AppCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension AppCoordinator {
    
    internal func loadSplashScreen() {
        OperationQueue.main.addOperation {
            if let splashController = ViewLoader.load(SplashController.self, xibName: XIBS.Controllers.splash) {
                splashController.bind(SplashViewModel(self))
                self.navigationController.show(splashController, sender: self)
            }
        }
    }
    
    internal func loadAuthentication() {
        let authCoordinator = AuthCoordinator(self.navigationController, parentDelegate: self)
        authCoordinator.start()
    }
    
    /*
    
    
    func loadHome() {
        <#code#>
    }
    
    func loadOfferService() {
        <#code#>
    }
    
    func loadRequestService() {
        <#code#>
    }
    
    func loadRequestCredits() {
        <#code#>
    }
    
    func loadUpdateProfile() {
        <#code#>
    }*/
}
