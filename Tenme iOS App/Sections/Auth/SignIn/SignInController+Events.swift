//
//  SignInController+Events.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension SignInController {
    @IBAction func loginBtnTouched(_ sender: Any) {
        if let phoneNumber = self.phoneTxt?.text,
            let parsedPhoneNumber = Int(phoneNumber) {
            self.viewModel.checkUser(phoneNumber: parsedPhoneNumber)
        } else {
            showAlert(title: nil, message: "Debe introducir un número de teléfono válido para continuar.")
        }
    }
    
    @IBAction func facebookLoginBtnTouched(_ sender: Any) {
        facebookSignIn()
    }
    
    @IBAction func countryCodeBtnTouched(_ sender: Any) {
        viewModel.showCountries()
    }
}
