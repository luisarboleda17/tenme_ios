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
    func checkUser(phoneNumber: Int)
    func getFacebookUser(token: String)
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
    
    /**
     Check if user exist on database
     */
    func checkUser(phoneNumber: Int) {
        if let code = selectedCountry.countryCode,
            let parsedCompletePhone = Int(String(code) + String(phoneNumber)) {
            
            viewDelegate.showLoading(
                loading: true,
                completion: {
                    Alamofire.request(
                        API.Auth.checkUser + String(parsedCompletePhone)
                        ).validate().responseData(
                            queue: DispatchQueue.backgroundQueue,
                            completionHandler: { response in
                                self.viewDelegate.showLoading(
                                    loading: false,
                                    completion: {
                                        switch response.result {
                                        case .success(let data):
                                            if let parsedResponse = data.toObject(objectType: CheckUserResponse.self) {
                                                if (parsedResponse.exist) {
                                                    self.navDelegate.phoneFilled(phone: parsedCompletePhone)
                                                } else {
                                                    self.navDelegate.requestSignUp(countryCode: code, phoneNumber: phoneNumber)
                                                }
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
    }
    
    func getFacebookUser(token: String) {
        let connection = GraphRequestConnection()
        let request = GraphRequest(
            graphPath: "/me",
            parameters: [
                "fields": ["email", "first_name", "last_name", "id"]
            ],
            tokenString: token,
            version: nil,
            httpMethod: .get
        )
        connection.add(
            request,
            completionHandler: { response, result, error  in
                if let error = error {
                    self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "\(error)")
                    return
                }
                if let userData = result as? [String: Any],
                    let id = userData["id"] as? Int,
                    let firstName = userData["first_name"] as? String?,
                    let lastName = userData["last_name"] as? String?,
                    let email = userData["email"] as? String? {
                    
                    
                } else {
                    self.viewDelegate.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error obteniendo los datos del usuario.")
                }
            }
        )
        
        connection.start()
    }
}
