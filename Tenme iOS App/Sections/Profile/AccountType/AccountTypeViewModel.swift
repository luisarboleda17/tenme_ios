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
    init(_ navDelegate: AppCoordinatorProtocol)
    
    func getType(forIndex index: Int) -> BankAccount.AccountType
    func getTypesNumber() -> Int
    func select(typeAtIndex index: Int)
}

class AccountTypeViewModel: AccountTypeViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    
    private var types: [BankAccount.AccountType] = [
        BankAccount.AccountType.saving,
        BankAccount.AccountType.checking
    ]
    
    required init(_ navDelegate: AppCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getType(forIndex index: Int) -> BankAccount.AccountType {
        return types[index]
    }
    
    func getTypesNumber() -> Int {
        return types.count
    }
    
    func select(typeAtIndex index: Int) {
        navDelegate.selected(type: types[index])
    }
}
