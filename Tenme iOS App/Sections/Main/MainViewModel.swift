//
//  MainViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
    var navDelegate: AppCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AppCoordinatorProtocol)
}

class MainViewModel: MainViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    
    required init(_ navDelegate: AppCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
}
