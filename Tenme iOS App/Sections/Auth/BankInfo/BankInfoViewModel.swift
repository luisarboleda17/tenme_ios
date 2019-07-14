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
    init(_ navDelegate: AuthCoordinatorProtocol, request: SignUpRequest)
}

class BankInfoViewModel: BankInfoViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var signUpRequest: SignUpRequest!
    
    required init(_ navDelegate: AuthCoordinatorProtocol, request: SignUpRequest) {
        self.navDelegate = navDelegate
        self.signUpRequest = request
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
}

