//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol BankAccountFormViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: BankAccountFormControllerProtocol)
    
    func showAccountTypes()
    func showBanks()
    
    func set(bank: Bank)
    func set(accountType: BankAccount.AccountType)
    func set(accountNumber: Int)
}

class BankAccountFormViewModel: BankAccountFormViewModelProtocol {
    internal var viewDelegate: BankAccountFormControllerProtocol!
    internal var navDelegate: AppCoordinatorProtocol!
    
    internal var bankId: String?
    internal var accountType: BankAccount.AccountType?
    
    required init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: BankAccountFormControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func create(bankAccount: BankAccount) {
        print(bankAccount.toDict())
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.PaymentMethods.bankAccounts,
                    method: .post,
                    parameters: bankAccount.toDict(),
                    encoding: JSONEncoding.default,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success:
                                        self.navDelegate.returnMain()
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error registrando usuario", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
        }
        )
    }
    
    // MARK: - View model methods
    
    func showAccountTypes() {
        navDelegate.showAccountTypes()
    }
    
    func showBanks() {
        navDelegate.showBanks()
    }
    
    func set(bank: Bank) {
        bankId = bank.id
        viewDelegate.update(bankName: bank.name)
    }
    
    func set(accountType: BankAccount.AccountType) {
        self.accountType = accountType
        viewDelegate.update(accountType: accountType == .saving ? "Cuenta de ahorro" : "Cuenta corriente")
    }
    
    func set(accountNumber: Int) {
        guard let bankId = self.bankId else {
            viewDelegate.showAlert(title: "Información requerida", message: "Debes seleccionar un banco")
            return
        }
        guard let accountType = self.accountType else {
            viewDelegate.showAlert(title: "Información requerida", message: "Debes seleccionar un tipo de cuenta")
            return
        }
        
        let account = BankAccount(id: "", bankId: bankId, type: accountType, number: accountNumber, bankName: nil)
        self.create(bankAccount: account)
    }
}

