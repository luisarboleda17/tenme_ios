//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol AccountTypeViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol)
    
    func getType(forIndex index: Int) -> BankAccountType
    func getTypesNumber() -> Int
    func select(typeAtIndex index: Int)
}

class AccountTypeViewModel: AccountTypeViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    private var types: [BankAccountType] = [
        BankAccountType.saving,
        BankAccountType.checking
    ]
    
    required init(_ navDelegate: AuthCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getType(forIndex index: Int) -> BankAccountType {
        return types[index]
    }
    
    func getTypesNumber() -> Int {
        return types.count
    }
    
    func select(typeAtIndex index: Int) {
        navDelegate.selected(type: types[index])
    }
}
