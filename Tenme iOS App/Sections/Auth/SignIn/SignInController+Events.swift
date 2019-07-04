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
        if let countryCode = self.countryCodeTxt?.text,
            let phoneNumber = self.phoneTxt?.text,
            let parsedCountryCode = Int(countryCode),
            let parsedPhoneNumber = Int(phoneNumber) {
            self.viewModel.checkUser(countryCode: parsedCountryCode, phoneNumber: parsedPhoneNumber)
        }
    }
    
    @IBAction func signUpBtnTouched(_ sender: Any) {
        viewModel.requestSignUp()
    }
}
