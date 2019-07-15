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
    func requestSignUp(countryCode: Int?, phoneNumber: Int?)
    func personalInfoFilled(request: SignUpRequest)
    func showCountries()
    func showAccountTypes()
    func userAuthenticated()
    
    func selected(country: Country)
    func selected(type: BankAccountType)
}

class AuthCoordinator: AuthCoordinatorProtocol {
    internal let TAG = "AUTH COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var signUpViewModel: SignUpViewModelProtocol?
    internal var bankInfoViewModel: BankInfoViewModelProtocol?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    // MARK: - View model methods
    
    func start() {
        loadSignIn()
    }
    
    func requestSignUp(countryCode: Int?, phoneNumber: Int?) {
        loadSignUp(countryCode: countryCode, phoneNumber: phoneNumber)
    }
    
    func personalInfoFilled(request: SignUpRequest) {
        loadBankInfo(request: request)
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
    
    func showAccountTypes() {
        loadAccountTypeView()
    }
    
    func selected(country: Country) {
        if let signUpViewModel = self.signUpViewModel {
            signUpViewModel.set(countryCode: country)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func selected(type: BankAccountType) {
        if let bankInfoViewModel = self.bankInfoViewModel {
            bankInfoViewModel.set(accountType: type)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
}
