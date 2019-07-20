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
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignInControllerProtocol)
    
    func getDefaultCountryCode() -> Int
    func showCountries()
    func checkUser(phoneNumber: Int)
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
            
            Alamofire.request(
                API.Auth.checkUser + String(parsedCompletePhone)
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
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
    }
}
