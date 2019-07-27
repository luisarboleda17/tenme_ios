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
                
                mainController.bind(MainViewModel(self, viewDelegate: mainController))
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
    
    internal func loadRequestCreditsView() {
        let requestCreditsCoordinator = RequestCreditsCoordinator(navigationController, parentDelegate: self)
        requestCreditsCoordinator.start()
    }
    
    internal func loadHistory() {
        OperationQueue.main.addOperation {
            if let historyController = ViewLoader.load(HistoryController.self, xibName: XIBS.Controllers.history) {
                
                historyController.bind(HistoryViewModel(self, viewDelegate: historyController))
                self.navigationController.show(historyController, sender: self)
            }
        }
    }
    
    internal func loadProfileView(balance: Decimal) {
        OperationQueue.main.addOperation {
            if let profileController = ViewLoader.load(ProfileViewController.self, xibName: XIBS.Controllers.profile) {
                
                profileController.bind(ProfileViewModel(self, viewDelegate: profileController, balance: balance))
                self.navigationController.show(profileController, sender: self)
            }
        }
    }
    
    internal func loadUpdateProfile() {
        OperationQueue.main.addOperation {
            if let profileController = ViewLoader.load(UpdateProfileController.self, xibName: XIBS.Controllers.updateProfile) {
                
                profileController.bind(UpdateProfileViewModel(self, viewDelegate: profileController))
                self.navigationController.show(profileController, sender: self)
            }
        }
    }
    
    func returnMainView() {
        OperationQueue.main.addOperation {
            if let mainView = self.mainViewController {
                self.navigationController.popToViewController(mainView, animated: true)
            }
        }
    }
}
