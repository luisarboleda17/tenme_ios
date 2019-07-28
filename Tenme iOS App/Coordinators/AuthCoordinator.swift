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
    func phoneFilled(phone: Int)
    func requestSignUp(countryCode: Int?, phoneNumber: Int?, facebookUser: FacebookUser?)
    func showCountries()
    func userAuthenticated()
    
    func selected(country: Country)
}

protocol CountrySelectionProtocol {
    func set(countryCode: Country)
}

class AuthCoordinator: AuthCoordinatorProtocol {
    internal let TAG = "AUTH COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var countrySelectionViewModel: CountrySelectionProtocol?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    // MARK: - View model methods
    
    func start() {
        loadSignIn()
    }
    
    func requestSignUp(countryCode: Int?, phoneNumber: Int?, facebookUser: FacebookUser?) {
        loadSignUp(countryCode: countryCode, phoneNumber: phoneNumber, facebookUser: facebookUser)
    }

    func phoneFilled(phone: Int) {
        loadPassword(phone: phone)
    }
    
    func userAuthenticated() {
        parentDelegate.userAuthenticated()
    }
    
    func showCountries() {
        loadCountryCodeView()
    }
    
    func selected(country: Country) {
        if let countrySelectionViewModel = self.countrySelectionViewModel {
            countrySelectionViewModel.set(countryCode: country)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
}
