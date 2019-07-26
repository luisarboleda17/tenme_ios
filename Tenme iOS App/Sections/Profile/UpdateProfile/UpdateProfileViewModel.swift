//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

struct PasswordSet {
    let old: String
    let new: String
    
    func toDict() -> [String: String] {
        return [
            "old": old,
            "new": new
        ]
    }
}

protocol UpdateProfileViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: UpdateProfileControllerProtocol)
    
    func getFirstName() -> String?
    func getLastName() -> String?
    func getEmail() -> String?
    
    func set(firstName: String?, lastName: String?, email: String?, password: PasswordSet?)
}

class UpdateProfileViewModel: UpdateProfileViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    internal var viewDelegate: UpdateProfileControllerProtocol!
    
    required init(
        _ navDelegate: AppCoordinatorProtocol,
        viewDelegate: UpdateProfileControllerProtocol) {
        
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    // MARK: - View model methods
    
    func getFirstName() -> String? {
        return UserSession.current.user?.firstName
    }
    
    func getLastName() -> String? {
        return UserSession.current.user?.lastName
    }
    
    func getEmail() -> String? {
        return UserSession.current.user?.email
    }
    
    func set(firstName: String?, lastName: String?, email: String?, password: PasswordSet?) {
        var modifiedFields: [String:Any] = [:]
        
        // Check if fields has changed
        
        if let fName = firstName, firstName != UserSession.current.user?.firstName {
            modifiedFields["firstName"] = fName
        }

        if let lName = lastName, lastName != UserSession.current.user?.lastName {
            modifiedFields["lastName"] = lName
        }
        
        if let newEmail = email, email != UserSession.current.user?.email {
            modifiedFields["email"] = newEmail
        }
        
        if let passwordChange = password {
            modifiedFields["password"] = passwordChange.toDict()
        }
        
        guard modifiedFields.count > 0 else {
            print("No fields to modify.")
            navDelegate.returnMain()
            return
        }
        
        viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.User.me,
                    method: .patch,
                    parameters: modifiedFields,
                    encoding: JSONEncoding.default,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                ).responseData(
                    queue: DispatchQueue.backgroundQueue,
                    completionHandler: { response in
                        self.viewDelegate.showLoading(
                            loading: false,
                            completion: {
                                switch response.result {
                                case .success(let data):
                                    
                                    // Validate status code
                                    if let statusCode = response.response?.statusCode {

                                        switch statusCode {
                                        case 200...299:
                                            if let parsedResponse = data.toObject(objectType: UpdateUserResponse.self) {
                                                // Update user data
                                                UserSession.current.updateUser(firstName: parsedResponse.firstName, lastName: parsedResponse.lastName, email: parsedResponse.email)
                                                
                                                self.viewDelegate.showAlert(
                                                    title: "Perfil actualizado",
                                                    message: "Se ha modificado correctamente el perfil.",
                                                    completion: { _ in
                                                        // Inform coordinator that user was updated
                                                        self.navDelegate.returnMain()
                                                    }
                                                )
                                            } else {
                                                self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "Ha ocurrido un error desconocido")
                                            }
                                        case 400:
                                            self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "Debe completar al menos un campo")
                                        case 403:
                                            self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "La contraseña actual no es válida")
                                        default:
                                            self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "Ha ocurrido un error desconocido")
                                        }
                                        
                                    } else {
                                        self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "No es posible conectarse a los servidores de Tenme")
                                    }
                                case .failure(let error):
                                    self.viewDelegate.showAlert(title: "Error actualizando el perfil", message: "\(error)")
                                }
                            }
                        )
                    }
                )
            }
        )
    }
}

