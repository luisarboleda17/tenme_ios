//
//  PasswordViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol PasswordViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol, phone: Int)
    
    func signIn(password: String)
}

class PasswordViewModel: PasswordViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var phone: Int!
    
    required init(_ navDelegate: AuthCoordinatorProtocol, phone: Int) {
        self.navDelegate = navDelegate
        self.phone = phone
    }
    
    func signIn(password: String) {
        navDelegate.userAuthenticated()
    }
}

