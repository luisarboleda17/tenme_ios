//
//  SplashViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol SplashViewModelProtocol {
    var navDelegate: AppCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AppCoordinatorProtocol)
    
    func loaded()
}

class SplashViewModel: SplashViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    
    required init(_ navDelegate: AppCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func loaded() {
        self.navDelegate.appLoaded()
    }
}
