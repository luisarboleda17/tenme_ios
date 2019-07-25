//
//  SignInViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire
import FBSDKLoginKit

protocol SignInViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignInControllerProtocol)
    
    func getDefaultCountryCode() -> Int
    func showCountries()
    func signIn(phoneNumber: Int)
    func signIn(token: String)
}

class SignInViewModel: SignInViewModelProtocol, CountrySelectionProtocol {
    internal var viewDelegate: (SignInControllerProtocol & AlertHandlerView)!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    private var selectedCountry: Country = Country(code: 507, name: "Panamá")
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignInControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }

    func set(countryCode: Country) {
        self.selectedCountry = countryCode
        self.viewDelegate.update(countryCode: countryCode.countryCode ?? 0)
    }
    
    /**
     Check if user exist on database
     */
    private func checkUser(phoneNumber: Int?, facebookId: String?, completionHandler: @escaping (Bool?, Error?) -> ()) {
        guard phoneNumber != nil || facebookId != nil else {
            print("No parameters passed")
            return
        }
        
        var parameters: [String:Any] = [:]
        
        if let phone = phoneNumber {
            parameters["phone"] = phone
        }
        if let fbId = facebookId {
            parameters["facebookId"] = fbId
        }
        
        viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Auth.checkUser,
                    method: .get,
                    parameters: parameters,
                    encoding: URLEncoding.default
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success(let data):
                                        completionHandler(data.toObject(objectType: CheckUserResponse.self)?.exist, nil)
                                    case .failure(let error):
                                        completionHandler(nil, error)
                                    }
                                }
                            )
                    }
                )
            }
        )
    }
    
    private func performFacebookSignIn(id: String) {
        viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Auth.login,
                    method: .post,
                    parameters: [
                        "facebookId": id
                    ],
                    encoding: JSONEncoding.default
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success(let data):
                                        if let parsedResponse = data.toObject(objectType: SignInResponse.self) {
                                            // Open user session
                                            UserSession.current.open(forUser: parsedResponse.user, token: parsedResponse.token)
                                            
                                            // Inform coordinator that user is ready
                                            self.navDelegate.userAuthenticated()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "\(error)")
                                    }
                                }
                            )
                    }
                )
        }
        )
    }
    
    // MARK: View model methods
    
    func getDefaultCountryCode() -> Int {
        return self.selectedCountry.countryCode ?? 0
    }
    
    func showCountries() {
        navDelegate.showCountries()
    }
    
    func selected(country: Country) {
        self.selectedCountry = country
        self.viewDelegate.update(countryCode: country.countryCode ?? 0)
    }
    
    func signIn(phoneNumber: Int) {
        if let code = selectedCountry.countryCode,
            let parsedCompletePhone = Int(String(code) + String(phoneNumber)) {
            
            checkUser(
                phoneNumber: parsedCompletePhone,
                facebookId: nil,
                completionHandler: { exist, error in
                    if let exist = exist {
                        if (exist) {
                            self.navDelegate.phoneFilled(phone: parsedCompletePhone)
                        } else {
                            self.navDelegate.requestSignUp(countryCode: code, phoneNumber: phoneNumber, facebookUser: nil)
                        }
                    } else {
                        self.viewDelegate.showAlert(title: "Error iniciando sesión", message: error != nil ? "\(error!)" : "Ha ocurrido un error desconocido")
                    }
                }
            )
        }
    }
    
    func signIn(token: String) {
        let connection = GraphRequestConnection()
        let request = GraphRequest(
            graphPath: "/me?fields=email,first_name,last_name,id",
            parameters: [:],
            tokenString: token,
            version: nil,
            httpMethod: .get
        )
        connection.add(
            request,
            completionHandler: { response, result, error  in
                if let error = error {
                    self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "\(error)")
                    print("Error de grap connection")
                    return
                }
                if let userData = result as? [String: Any],
                    let id = userData["id"] as? String {
                    
                    let firstName = userData["first_name"] as? String
                    let lastName = userData["last_name"] as? String
                    let email = userData["email"] as? String
                    
                    self.checkUser(
                        phoneNumber: nil,
                        facebookId: id,
                        completionHandler: { exist, error in
                            if let exist = exist {
                                if (exist) {
                                    self.performFacebookSignIn(id: id)
                                } else {
                                    self.navDelegate.requestSignUp(
                                        countryCode: nil,
                                        phoneNumber: nil,
                                        facebookUser: FacebookUser(id: id, firstName: firstName, lastName: lastName, email: email)
                                    )
                                }
                            } else {
                                self.viewDelegate.showAlert(title: "Error iniciando sesión", message: error != nil ? "\(error!)" : "Ha ocurrido un error desconocido")
                            }
                        }
                    )
                } else {
                    self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error obteniendo los datos del usuario.")
                }
            }
        )
        connection.start()
    }
}
