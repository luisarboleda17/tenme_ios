//
//  SignUpController+Events.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension SignUpController {
    @IBAction func signBtnTouched(_ sender: Any) {
        guard let countryCode = self.countryCodeTxt.text,
            let phoneNumber = self.phoneNumberTxt.text else {
            print("Phone not valid")
            return
        }
        
        guard let id = self.idTxt.text else {
            print("Id not valid")
            return
        }
        
        guard let firstName = self.firstNameTxt.text, let lastName = self.lastNameTxt.text else {
            print("Names not valid")
            return
        }
        
        guard let email = self.emailTxt.text else {
            print("Email not valid")
            return
        }
        
        guard let bankId = self.bankTxt.text,
            let accountType = self.accountTypeTxt.text,
            let accountNumber = self.accountNumberTxt.text else {
            print("Bank not valid")
            return
        }
        
        viewModel.setPhone(countryCode: Int(countryCode) ?? 0, phoneNumber: Int(phoneNumber) ?? 0)
        viewModel.set(id: id, type: self.passportSwitch.isOn ? .passport : .id)
        viewModel.set(firstName: firstName, lastName: lastName)
        viewModel.set(email: email)
        viewModel.set(bankId: bankId, accountType: BankAccountType(rawValue: accountType) ?? .saving, accountNumber: Int(accountNumber) ?? 0)
        viewModel.set(apcAllowed: self.apcSwitch.isOn)
        
        if let password = self.passwordTxt.text {
            viewModel.set(password: password)
        }
        
        viewModel.signUp()
    }
}
