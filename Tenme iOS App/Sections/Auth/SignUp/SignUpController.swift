//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol SignUpControllerProtocol: AlertHandlerView {
    func update(countryCode: Country)
}

class SignUpController: UIViewController, BindableController, TableView, SignUpControllerProtocol, TableViewKeyboardProtocol {
    typealias ViewModel = SignUpViewModelProtocol
    
    internal var viewModel: SignUpViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var formTable: UITableView!
    internal var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc internal func keyboardShow(notification: NSNotification) {
        keyboardWillShow(notification: notification)
    }
    
    @objc internal func keyboardHide(notification: NSNotification) {
        keyboardWillHide(notification: notification)
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Continuar",
            style: .done,
            target: self,
            action: #selector(signUp)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
        self.title = "Registro"
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
        
        let apcCell = formTable.cellForRow(at: IndexPath(row: 0, section: 2)) as! SwitchCell
        
        guard let phoneString = phoneCell.textField.text, phoneCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir un número de teléfono")
            return
        }
        guard let phoneNumber = Int(phoneString) else {
            showAlert(title: "Información requerida", message: "Debe introducir un número de teléfono válido")
            return
        }
        guard let email = emailCell.textField.text, emailCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir un correo electrónico")
            return
        }
        guard email.contains("@") else {
            showAlert(title: "Información requerida", message: "Debe introducir un correo electrónico válido")
            return
        }
        guard let password = passwordCell.textField.text, passwordCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir una contraseña")
            return
        }
        guard password.count >= 8 && password.count <= 16 else {
            showAlert(title: "Información requerida", message: "Debe introducir una contraseña de entre 8 y 16 caracteres")
            return
        }
        
        guard let id = idCell.textField.text, idCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir su número de identificación")
            return
        }
        guard id.contains("-") else {
            showAlert(title: "Información requerida", message: "Debe introducir su número de identificación con guiones")
            return
        }
        guard let isPassport = passportCell.active else {
            print("Error getting if is passport")
            return
        }
        guard let firstName = firstNameCell.textField.text, firstNameCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir su primer nombre")
            return
        }
        guard let lastName = lastNameCell.textField.text, lastNameCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir su apellido")
            return
        }
        
        guard let apcAllowed = apcCell.active else {
            print("Error getting apc validation")
            return
        }
        
        viewModel.set(
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            id: id,
            passport: isPassport,
            firstName: firstName,
            lastName: lastName,
            apcAllowed: apcAllowed
        )
        
        viewModel.signUp()
    }
    
    // MARK: - View delegate methods
    
    internal func update(countryCode: Country) {
        OperationQueue.main.addOperation {
            let countryCodeCell = self.formTable.cellForRow(at: IndexPath(row: 0, section: 0))
            countryCodeCell?.detailTextLabel?.text = "+" + String(countryCode.countryCode ?? 0) + " " + countryCode.name
        }
    }
}
