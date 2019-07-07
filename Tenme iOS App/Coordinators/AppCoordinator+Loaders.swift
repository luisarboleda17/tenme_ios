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
    
    internal func loadMainView() {
        OperationQueue.main.addOperation {
            if let mainController = ViewLoader.load(MainController.self, xibName: XIBS.Controllers.main) {
                mainController.bind(MainViewModel(self))
                self.navigationController.show(mainController, sender: self)
            }
        }
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
