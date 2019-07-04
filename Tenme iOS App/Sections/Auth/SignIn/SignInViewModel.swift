//
//  SignInViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol SignInViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol)
    
    func checkUser(countryCode: Int, phoneNumber: Int)
    func requestSignUp()
}

class SignInViewModel: SignInViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    required init(_ navDelegate: AuthCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    /**
     Check if user exist on database
     */
    func checkUser(countryCode: Int, phoneNumber: Int) {
        let completePhone = String(countryCode) + String(phoneNumber)
        if let parsedCompletePhone = Int(completePhone) {
            Alamofire.request(
                API.Auth.login,
                method: .post,
                parameters: [
                    "phone": completePhone,
                    "password": "" // TODO: Should add check user
                ],
                encoding: JSONEncoding.default
            ).validate().responseJSON {
                response in
                print(response)
                self.navDelegate.phoneFilled(phone: parsedCompletePhone)
            }
        }
    }
    
    /**
     Request view to sign up
     */
    func requestSignUp() {
        navDelegate.requestSignUp()
    }
}
