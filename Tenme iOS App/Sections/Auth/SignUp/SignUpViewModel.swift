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
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignUpControllerProtocol, countryCode: Int?, phoneNumber: Int?, facebookUser: FacebookUser?)
    
    func showCountries()
    
    func getPhone() -> Phone?
    func getFirstName() -> String?
    func getLastName() -> String?
    func getEmail() -> String?
    func set(countryCode: Country)
    func set(phoneNumber: Int, email: String?, password: String?, id: String, passport: Bool, firstName: String, lastName: String, apcAllowed: Bool)
    func signUp()
}

class SignUpViewModel: SignUpViewModelProtocol, CountrySelectionProtocol {
    internal var navDelegate: AuthCoordinatorProtocol!
    internal var viewDelegate: SignUpControllerProtocol!
    
    internal var signUpRequest: SignUpRequest = SignUpRequest()
    private var usedFacebook = false
    
    required init(
        _ navDelegate: AuthCoordinatorProtocol,
        viewDelegate: SignUpControllerProtocol,
        countryCode: Int?,
        phoneNumber: Int?,
        facebookUser: FacebookUser?) {
        
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        
        if let fbUser = facebookUser {
            usedFacebook = true
            
            signUpRequest.facebookId = fbUser.id
            signUpRequest.firstName = fbUser.firstName
            signUpRequest.lastName = fbUser.lastName
            signUpRequest.email = fbUser.email
        } else {
            if let countryCode = countryCode, let phone = phoneNumber {
                signUpRequest.phone = Phone(countryCode: countryCode, phoneNumber: phone)
            }
        }
    }
    
    // MARK: - View model methods
    
    func showCountries() {
        navDelegate.showCountries()
    }
    
    func getPhone() -> Phone? {
        return self.signUpRequest.phone
    }
    
    func getFirstName() -> String? {
        return self.signUpRequest.firstName
    }
    
    func getLastName() -> String? {
        return self.signUpRequest.lastName
    }
    
    func getEmail() -> String? {
        return self.signUpRequest.email
    }
    
    func set(countryCode: Country) {
        if let code = countryCode.countryCode {
            self.signUpRequest.phone = Phone(countryCode: code, phoneNumber: 0)
            viewDelegate.update(countryCode: countryCode)
        }
    }
    
    func set(phoneNumber: Int, email: String?, password: String?, id: String, passport: Bool, firstName: String, lastName: String, apcAllowed: Bool) {
        self.signUpRequest.phone?.phoneNumber = phoneNumber
        signUpRequest.email = email
        signUpRequest.password = password
        signUpRequest.document = Document(type: passport ? .passport : .id, id: id)
        signUpRequest.firstName = firstName
        signUpRequest.lastName = lastName
        signUpRequest.apcAllowed = apcAllowed
    }
    
    func signUp() {
        guard signUpRequest.phone != nil else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe llenar la información telefónica")
            return
        }
        if let requestParams = signUpRequest.toDictionary() {
            self.viewDelegate.showLoading(
                loading: true,
                completion: {
                    Alamofire.request(
                        API.Auth.signUp,
                        method: .post,
                        parameters: requestParams,
                        encoding: JSONEncoding.default
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
                                                    if let parsedResponse = data.toObject(objectType: SignInResponse.self) {
                                                        // Open user session
                                                        UserSession.current.open(forUser: parsedResponse.user, token: parsedResponse.token)
                                                        
                                                        // Inform coordinator that user is ready
                                                        self.navDelegate.userAuthenticated()
                                                    } else {
                                                        self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ha ocurrido un error desconocido")
                                                    }
                                                case 400:
                                                    self.viewDelegate.showAlert(title: "Información requerida", message: "Debe rellenar todos los campos para continuar")
                                                case 409:
                                                    self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ya existe un usuario con estos datos")
                                                default:
                                                    self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ha ocurrido un error desconocido")
                                                }
                                                
                                            } else {
                                                self.viewDelegate.showAlert(title: "Error registrando usuario", message: "No es posible conectarse a los servidores de Tenme")
                                            }
                                        case .failure(let error):
                                            self.viewDelegate.showAlert(title: "Error registrando usuario", message: "\(error)")
                                        }
                                }
                                )
                        }
                    )
            }
            )
        } else {
            print("No se puede parsear")
        }
    }
}
