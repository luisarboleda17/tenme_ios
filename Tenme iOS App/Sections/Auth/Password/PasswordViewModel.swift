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
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: AlertHandlerView, phone: Int)
    
    func signIn(password: String)
}

class PasswordViewModel: PasswordViewModelProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    internal var viewDelegate: AlertHandlerView!
    
    internal var phone: Int!
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: AlertHandlerView, phone: Int) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.phone = phone
    }
    
    func signIn(password: String) {
        Alamofire.request(
            API.Auth.login,
            method: .post,
            parameters: [
                "phone": self.phone,
                "password": password
            ],
            encoding: JSONEncoding.default
        ).responseData(
            queue: DispatchQueue.backgroundQueue,
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    
                    // Validate status code
                    if let statusCode = response.response?.statusCode {
                        
                        switch statusCode {
                        case 200...299:
                            if let parsedResponse = data.toObject(objectType: SignInResponse.self) {
                                // Open user session
                                UserSession.current.open(forUser: parsedResponse.user, token: parsedResponse.token)
                                
                                // Inform coordinator that user is ready
                                self.navDelegate.userAuthenticated()
                            } else {
                                self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error desconocido")
                            }
                        case 400:
                            self.viewDelegate.showAlert(title: nil, message: "Contraseña incorrecta")
                        default:
                            self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error desconocido")
                        }
                        
                    } else {
                        self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "No es posible conectarse a los servidores de Tenme")
                    }
                case .failure(let error):
                    self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "\(error)")
                }
            }
        )
    }
}

