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
    
    func getCountriesNumber() -> Int
    func getCountry(forRow row: Int) -> Country
    func selectCountry(atRow row: Int)
    func checkUser(phoneNumber: Int)
}

class SignInViewModel: SignInViewModelProtocol {
    internal var viewDelegate: SignInControllerProtocol!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    private var countries: [Country] = [
        Country(code: 507, name: "Panamá"),
        Country(code: 504, name: "Honduras"),
        Country(code: 1, name: "Estados Unidos")
    ]
    private var selectedCountry: Country?
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: SignInControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }

    // MARK: View model methods
    
    func getCountriesNumber() -> Int {
        return countries.count
    }
    
    func getCountry(forRow row: Int) -> Country {
        return countries[row]
    }
    
    func selectCountry(atRow row: Int) {
        selectedCountry = countries[row]
        viewDelegate.update(countryCode: countries[row].countryCode ?? 0)
    }
    
    /**
     Check if user exist on database
     */
    func checkUser(phoneNumber: Int) {
        if let code = selectedCountry?.countryCode,
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
                        print("Error checking user... \(error)") // TODO: Add error handler
                    }
                }
            )
        }
    }
}
