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
                API.Auth.checkUser + completePhone
            ).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String: Bool],
                        let exist = data["exist"] {
                        if (exist) {
                            self.navDelegate.phoneFilled(phone: parsedCompletePhone)
                        } else {
                            self.navDelegate.requestSignUp()
                        }
                    }
                case .failure(let error):
                    print("Error checking user... \(error)") // TODO: Add error handler
                }
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
