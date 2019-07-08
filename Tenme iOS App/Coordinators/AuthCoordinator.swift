//
//  AuthCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
    var parentDelegate: AppCoordinatorProtocol! { get set }
    var navigationController: UINavigationController! { get set }

    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func requestSignUp(countryCode: Int?, phoneNumber: Int?)
    func phoneFilled(phone: Int)
    func userAuthenticated()
}

class AuthCoordinator: AuthCoordinatorProtocol {
    internal let TAG = "AUTH COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadSignIn()
    }
    
    func requestSignUp(countryCode: Int?, phoneNumber: Int?) {
        loadSignUp(countryCode: countryCode, phoneNumber: phoneNumber)
    }
    
    func phoneFilled(phone: Int) {
        loadPassword(phone: phone)
    }
    
    func userAuthenticated() {
        parentDelegate.userAuthenticated()
    }
}
