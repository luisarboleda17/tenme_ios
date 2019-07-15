//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol CountryCodeViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: CountryCodeControllerProtocol)
    
    func getCountry(forIndex index: Int) -> Country
    func getCountriesNumber() -> Int
    func select(countryAtIndex index: Int)
    func viewDidLoad()
}

class CountryCodeViewModel: CountryCodeViewModelProtocol {
    internal var viewDelegate: CountryCodeControllerProtocol!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    private var countries: [Country] = []
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: CountryCodeControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getCountries()
    }
    
    private func getCountries() {
        /*
        Alamofire.request(
            API.Service.categories,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
        ).validate().responseData(
            queue: DispatchQueue.backgroundQueue,
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    if let categories = data.toObject(objectType: [Category].self) {
                        self.categories = categories
                        self.viewDelegate.refreshItems()
                    } else {
                        print("Error getting categories")
                    }
                case .failure(let error):
                    print("Error getting categories... \(error)") // TODO: Add error handler
                }
            }
        )*/
        countries = [
            Country(code: 507, name: "Panamá"),
            Country(code: 504, name: "Honduras"),
            Country(code: 1, name: "Estados Unidos")
        ]
        viewDelegate.refreshItems()
    }
    
    func getCountry(forIndex index: Int) -> Country {
        return countries[index]
    }
    
    func getCountriesNumber() -> Int {
        return countries.count
    }
    
    func select(countryAtIndex index: Int) {
        navDelegate.selected(country: countries[index])
    }
}
