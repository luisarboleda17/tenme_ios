//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol BankInfoViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankInfoControllerProtocol, request: SignUpRequest)
    
    func showAccountTypes()
    func showBanks()
    
    func signUp()
    func set(bank: Bank)
    func set(accountType: BankAccountType)
    func set(accountNumber: Int, apcAllowed: Bool)
}

class BankInfoViewModel: BankInfoViewModelProtocol {
    internal var viewDelegate: BankInfoControllerProtocol!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var signUpRequest: SignUpRequest!
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankInfoControllerProtocol, request: SignUpRequest) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.signUpRequest = request
        
        self.signUpRequest.bankInfo = BankInfo()
    }
    
    func signUp() {
        if let requestParams = signUpRequest.toDictionary() {
            Alamofire.request(
                API.Auth.signUp,
                method: .post,
                parameters: requestParams,
                encoding: JSONEncoding.default
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let parsedResponse = data.toObject(objectType: SignInResponse.self) {
                            
                            // Open user session
                            UserSession.current.open(forUser: parsedResponse.user, token: parsedResponse.token)
                            
                            // Inform coordinator that user is ready
                            self.navDelegate.userAuthenticated()
                        }
                    case .failure(let error):
                        print("Error \(error)")
                    }
                }
            )
        }
    }
    
    // MARK: - View model methods
    
    func showAccountTypes() {
        navDelegate.showAccountTypes()
    }
    
    func showBanks() {
        navDelegate.showBanks()
    }
    
    func set(bank: Bank) {
        signUpRequest.bankInfo?.bankId = bank.id
        viewDelegate.update(bankName: bank.name)
    }
    
    func set(accountType: BankAccountType) {
        signUpRequest.bankInfo?.accountType = accountType
        viewDelegate.update(accountType: accountType == .saving ? "Cuenta de ahorro" : "Cuenta corriente")
    }
    
    func set(accountNumber: Int, apcAllowed: Bool) {
        signUpRequest.bankInfo?.number = accountNumber
        signUpRequest.apcAllowed = apcAllowed
    }
}

