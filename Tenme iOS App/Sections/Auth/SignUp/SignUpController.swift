//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, BindableController {
    typealias ViewModel = SignUpViewModelProtocol
    
    internal var viewModel: SignUpViewModelProtocol!
    
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var secondNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var secondSurnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var bankTxt: UITextField!
    @IBOutlet weak var accountTypeTxt: UITextField!
    @IBOutlet weak var accountNumberTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passportSwitch: UISwitch!
    @IBOutlet weak var apcSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let phone = viewModel.getPhone() {
            self.countryCodeTxt.text = String(phone.countryCode)
            self.phoneNumberTxt.text = String(phone.phoneNumber)
        }
        
        configureView()
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Registro",
            style: .done,
            target: self,
            action: #selector(signUp)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
    }
    
    @objc private func signUp() {
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
