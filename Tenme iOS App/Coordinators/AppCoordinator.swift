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
    func loadRequestService()
    func loadRequestCredits()
    func returnMain()
}

class AppCoordinator: AppCoordinatorProtocol {
    internal let TAG = "APP COORDINATOR"
    internal var navigationController: UINavigationController {
        didSet { self.configureNavigationBar() }
    }
    
    internal var mainViewController: MainController?
    
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
    
    func loadRequestService() {
        loadRequestServiceView()
    }
    
    func loadRequestCredits() {
        loadRequestCreditsView()
    }
    
    func returnMain() {
        returnMainView()
    }
}
