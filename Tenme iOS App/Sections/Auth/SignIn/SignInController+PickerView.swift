//
//  SignInController+PickerView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/9/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension SignInController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getCountriesNumber()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let country = viewModel.getCountry(forRow: row)
        return "+" + String(country.countryCode ?? 0) + " " + country.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectCountry(atRow: row)
    }
}
