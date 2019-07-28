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
    func personalInfoFilled(request: SignUpRequest)
    func showCountries()
    func showAccountTypes()
    func showBanks()
    func userAuthenticated()
    
    func selected(country: Country)
    func selected(type: BankAccount.AccountType)
    func selected(bank: Bank)
}

protocol CountrySelectionProtocol {
    func set(countryCode: Country)
}

class AuthCoordinator: AuthCoordinatorProtocol {
    internal let TAG = "AUTH COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var countrySelectionViewModel: CountrySelectionProtocol?
    internal var bankInfoViewModel: BankInfoViewModelProtocol?
    
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
    
    func showBanks() {
        loadBankView()
    }
    
    func showAccountTypes() {
        loadAccountTypeView()
    }
    
    func selected(country: Country) {
        if let countrySelectionViewModel = self.countrySelectionViewModel {
            countrySelectionViewModel.set(countryCode: country)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func selected(type: BankAccount.AccountType) {
        if let bankInfoViewModel = self.bankInfoViewModel {
            bankInfoViewModel.set(accountType: type)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func selected(bank: Bank) {
        if let bankInfoViewModel = self.bankInfoViewModel {
            bankInfoViewModel.set(bank: bank)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
}
