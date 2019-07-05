//
//  PasswordViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol PasswordViewModelProtocol {
    var navDelegate: AuthCoordinatorProtocol! { get set }
    
    init(_ navDelegate: AuthCoordinatorProtocol, phone: Int)
    
    func signIn(password: String)
}

class PasswordViewModel: PasswordViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var phone: Int!
    
    required init(_ navDelegate: AuthCoordinatorProtocol, phone: Int) {
        self.navDelegate = navDelegate
        self.phone = phone
    }
    
    func signIn(password: String) {
        Alamofire.request(
            API.Auth.login,
            method: .post,
            parameters: [
                "phone": self.phone,
                "password": password
            ]).validate().responseData {
                response in
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
        
    }
}

