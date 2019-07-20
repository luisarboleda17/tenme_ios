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
        DispatchQueue.backgroundQueue.async {
            if let countryData = Data.from(fileAtUrl: "Countries", fileExtension: "json"),
                let countries = countryData.toObject(objectType: [Country].self) {
                self.countries = countries
                self.viewDelegate.refreshItems()
            } else {
                self.viewDelegate.showAlert(title: "Error obteniendo paises", message: "Ha ocurrido un error desconocido")
            }
        }
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
