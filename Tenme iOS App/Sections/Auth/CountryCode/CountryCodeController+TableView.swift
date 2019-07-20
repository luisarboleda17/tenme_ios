//
//  CategoryController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension CountryCodeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountriesNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: "country_code"
        )
        let country = viewModel.getCountry(forIndex: indexPath.row)
        
        cell.textLabel?.text = "+" + String(country.countryCode ?? 0) + " " + country.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(countryAtIndex: indexPath.row)
    }
}
