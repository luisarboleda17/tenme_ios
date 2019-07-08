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
                self.mainViewController = mainController
                
                mainController.bind(MainViewModel(self))
                self.navigationController.show(mainController, sender: self)
            }
        }
    }
    
    internal func loadPostService() {
        let postServiceCoordinator = PostServiceCoordinator(navigationController, parentDelegate: self)
        postServiceCoordinator.start()
    }
    
    internal func loadRequestServiceView() {
        let requestServiceCoordinator = RequestServiceCoordinator(navigationController, parentDelegate: self)
        requestServiceCoordinator.start()
    }
    
    func returnMainView() {
        if let mainView = mainViewController {
            navigationController.popToViewController(mainView, animated: true)
        }
    }
}
