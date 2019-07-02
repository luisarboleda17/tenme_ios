//
//  SignInViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol SignInViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol)
    
}

class SignInViewModel: SignInViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    required init(_ navDelegate: AuthCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
}
