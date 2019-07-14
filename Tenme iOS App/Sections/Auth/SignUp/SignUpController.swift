//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol SignUpControllerProtocol {
    func update(countryCode: Int)
}

class SignUpController: UIViewController, BindableController, TableView, SignUpControllerProtocol {
    typealias ViewModel = SignUpViewModelProtocol
    
    internal var viewModel: SignUpViewModelProtocol!
    
    @IBOutlet weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
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
        self.title = "Información personal"
        /*
        if let phone = viewModel.getPhone() {
            let countryCodeCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0))
            let phoneCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextEditCell
            countryCodeCell?.detailTextLabel?.text = "+" + String(phone.countryCode)
            phoneCell.fieldText = String(phone.phoneNumber)
        }*/
    }
    
    private func registerCells() {
        register(
            customCellWithName: Identifiers.Cells.textEdit,
            xibName: XIBS.Cells.textEdit,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.selection,
            xibName: XIBS.Cells.selection,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.optionSwitch,
            xibName: XIBS.Cells.switchCell,
            inTable: formTable
        )
    }
    
    @objc private func signUp() {
        let phoneCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextEditCell
        let emailCell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextEditCell
        let passwordCell = formTable.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextEditCell
        
        let idCell = formTable.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextEditCell
        let passportCell = formTable.cellForRow(at: IndexPath(row: 1, section: 1)) as! SwitchCell
        let firstNameCell = formTable.cellForRow(at: IndexPath(row: 2, section: 1)) as! TextEditCell
        let lastNameCell = formTable.cellForRow(at: IndexPath(row: 3, section: 1)) as! TextEditCell
        
        guard let phoneString = phoneCell.fieldText else {
            print("Id not valid")
            return
        }
        guard let phoneNumber = Int(phoneString) else {
            print("Id not valid")
            return
        }
        guard let email = emailCell.fieldText else {
            print("Id not valid")
            return
        }
        guard let password = passwordCell.fieldText else {
            print("Id not valid")
            return
        }
        
        guard let id = idCell.fieldText else {
            print("Id not valid")
            return
        }
        guard let isPassport = passportCell.active else {
            print("Id not valid")
            return
        }
        guard let firstName = firstNameCell.fieldText else {
            print("Id not valid")
            return
        }
        guard let lastName = lastNameCell.fieldText else {
            print("Id not valid")
            return
        }
        
        viewModel.set(
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            id: id,
            passport: isPassport,
            firstName: firstName,
            lastName: lastName
        )
        
        viewModel.signUp()
    }
    
    // MARK: - View delegate methods
    
    internal func update(countryCode: Int) {
        OperationQueue.main.addOperation {
            let countryCodeCell = self.formTable.cellForRow(at: IndexPath(row: 1, section: 0))
            countryCodeCell?.detailTextLabel?.text = "+" + String(countryCode)
        }
    }
}
