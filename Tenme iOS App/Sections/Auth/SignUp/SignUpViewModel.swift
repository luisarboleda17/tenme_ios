//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol)
    
    func signUp()
}

class SignUpViewModel: SignUpViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    required init(_ navDelegate: AuthCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func signUp() {
        navDelegate.userAuthenticated()
    }
}

