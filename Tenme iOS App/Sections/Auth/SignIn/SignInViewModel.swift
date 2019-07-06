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
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let parsedResponse = data.toObject(objectType: CheckUserResponse.self) {
                            if (parsedResponse.exist) {
                                self.navDelegate.phoneFilled(phone: parsedCompletePhone)
                            } else {
                                self.navDelegate.requestSignUp(countryCode: countryCode, phoneNumber: phoneNumber)
                            }
                        }
                    case .failure(let error):
                        print("Error checking user... \(error)") // TODO: Add error handler
                    }
                }
            )
        }
    }
}
