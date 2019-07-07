//
//  AppCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    init(_ navigationController: UINavigationController)
    
    func start()
    func appLoaded()
    func userAuthenticated()
    func loadOfferService()
    /*
    
    func loadHome()
    
    func loadRequestService()
    func loadRequestCredits()
    func loadUpdateProfile()*/
}

class AppCoordinator: AppCoordinatorProtocol {
    internal let TAG = "APP COORDINATOR"
    internal var navigationController: UINavigationController {
        didSet { self.configureNavigationBar() }
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func configureNavigationBar() {
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        loadSplashScreen()
    }
    
    func appLoaded() {
        print(UserSession.current.isOpen)
        if (UserSession.current.isOpen) {
            loadMainView()
        } else {
            loadAuthentication()
        }
    }
    
    func userAuthenticated() {
        loadMainView()
    }
    
    func loadOfferService() {
        loadPostService()
    }
}
