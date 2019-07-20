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
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignUpControllerProtocol, countryCode: Int?, phoneNumber: Int?)
    
    func showCountries()
    
    func getPhone() -> Phone?
    func set(countryCode: Country)
    func set(phoneNumber: Int, email: String?, password: String?, id: String, passport: Bool, firstName: String, lastName: String)
    func signUp()
}

class SignUpViewModel: SignUpViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    internal var viewDelegate: SignUpControllerProtocol!
    
    internal var signUpRequest: SignUpRequest = SignUpRequest()
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignUpControllerProtocol, countryCode: Int?, phoneNumber: Int?) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        
        if let countryCode = countryCode, let phone = phoneNumber {
            signUpRequest.phone = Phone(countryCode: countryCode, phoneNumber: phone)
        }
    }
    
    // MARK: - View model methods
    
    func showCountries() {
        navDelegate.showCountries()
    }
    
    func getPhone() -> Phone? {
        return self.signUpRequest.phone
    }
    
    func set(countryCode: Country) {
        if let code = countryCode.countryCode {
            self.signUpRequest.phone = Phone(countryCode: code, phoneNumber: 0)
            viewDelegate.update(countryCode: countryCode)
        }
    }
    
    func set(phoneNumber: Int, email: String?, password: String?, id: String, passport: Bool, firstName: String, lastName: String) {
        self.signUpRequest.phone?.phoneNumber = phoneNumber
        signUpRequest.email = email
        signUpRequest.password = password
        signUpRequest.document = Document(type: passport ? .passport : .id, id: id)
        signUpRequest.firstName = firstName
        signUpRequest.lastName = lastName
    }
    
    func signUp() {
        navDelegate.personalInfoFilled(request: self.signUpRequest)
    }
}

