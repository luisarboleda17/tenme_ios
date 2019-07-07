//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol SignUpViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol, countryCode: Int?, phoneNumber: Int?)
    
    func getPhone() -> Phone?
    func setPhone(countryCode: Int, phoneNumber: Int)
    func set(id: String, type: DocumentType)
    func set(firstName: String, lastName: String)
    func set(email: String)
    func set(bankId: String, accountType: BankAccountType, accountNumber: Int)
    func set(apcAllowed: Bool)
    func set(password: String)
    func signUp()
}

class SignUpViewModel: SignUpViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var signUpRequest: SignUpRequest = SignUpRequest()
    
    required init(_ navDelegate: AuthCoordinatorProtocol, countryCode: Int?, phoneNumber: Int?) {
        self.navDelegate = navDelegate
        
        if let countryCode = countryCode, let phone = phoneNumber {
            signUpRequest.phone = Phone(countryCode: countryCode, phoneNumber: phone)
        }
    }
    
    func signUp() {
        if let requestParams = signUpRequest.toDictionary() {
            print(requestParams)
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
    
    func getPhone() -> Phone? {
        return self.signUpRequest.phone
    }
    
    func setPhone(countryCode: Int, phoneNumber: Int) {
        signUpRequest.phone = Phone(countryCode: countryCode, phoneNumber: phoneNumber)
    }
    
    func set(id: String, type: DocumentType) {
        signUpRequest.document = Document(type: type, id: id)
    }
    
    func set(firstName: String, lastName: String) {
        signUpRequest.firstName = firstName
        signUpRequest.lastName = lastName
    }
    
    func set(email: String) {
        signUpRequest.email = email
    }
    
    func set(bankId: String, accountType: BankAccountType, accountNumber: Int) {
        signUpRequest.bankInfo = BankInfo(bankId: bankId, accountType: accountType, number: accountNumber)
    }
    
    func set(apcAllowed: Bool) {
        signUpRequest.apcAllowed = apcAllowed
    }
    
    func set(password: String) {
        signUpRequest.password = password
    }
}

