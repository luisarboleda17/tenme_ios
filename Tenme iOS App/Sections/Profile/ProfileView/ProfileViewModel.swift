//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol ProfileViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: ProfileViewControllerProtocol, balance: Decimal)
    
    func getBalance() -> Decimal
    
    func updateProfile()
    func managePaymentMethods()
}

class ProfileViewModel: ProfileViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    internal var viewDelegate: ProfileViewControllerProtocol!
    
    private var balance: Decimal = 0
    
    required init(
        _ navDelegate: AppCoordinatorProtocol,
        viewDelegate: ProfileViewControllerProtocol,
        balance: Decimal
    ) {
        
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.balance = balance
    }
    
    // MARK: - View model methods
    
    func getBalance() -> Decimal {
        return self.balance
    }
    
    func updateProfile() {
        
    }
    
    func managePaymentMethods() {
        
    }
}

