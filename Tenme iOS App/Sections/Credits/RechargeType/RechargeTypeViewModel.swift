//
//  RechargeTypeViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol RechargeTypeViewModelProtocol {
    init(navDelegate: RechargeCoordinatorProtocol)
    
    func recharge()
    func requestCredits()
}

class RechargeTypeViewModel: RechargeTypeViewModelProtocol {
    internal var navDelegate: RechargeCoordinatorProtocol!
    
    required init(navDelegate: RechargeCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func recharge() {
        navDelegate.recharge()
    }
    
    func requestCredits() {
        navDelegate.requestCredits()
    }
}
