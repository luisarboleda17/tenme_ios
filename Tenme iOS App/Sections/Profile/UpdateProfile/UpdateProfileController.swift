//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol UpdateProfileControllerProtocol: AlertHandlerView {}

class UpdateProfileController: UIViewController, BindableController, TableView, UpdateProfileControllerProtocol {
    typealias ViewModel = UpdateProfileViewModelProtocol
    
    internal var viewModel: UpdateProfileViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureView()
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Actualizar",
            style: .done,
            target: self,
            action: #selector(changeProfile)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
        self.title = "Actualizar perfil"
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
    
    @objc private func changeProfile() {
        let firstNameCell = formTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextEditCell
        let lastNameCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextEditCell
        let emailCell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextEditCell
        
        let oldPasswordCell = formTable.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextEditCell
        let newPasswordCell = formTable.cellForRow(at: IndexPath(row: 1, section: 1)) as! TextEditCell
        
        let firstName = firstNameCell.textField.text != "" ? firstNameCell.textField.text : nil
        let lastName = lastNameCell.textField.text != "" ? lastNameCell.textField.text : nil
        let email = emailCell.textField.text != "" ? emailCell.textField.text : nil
        var passwordChange: PasswordSet?
        
        if let oldPassword = oldPasswordCell.textField.text, oldPasswordCell.textField.text != "",
            let newPassword = newPasswordCell.textField.text, newPasswordCell.textField.text != "" {
            
            passwordChange = PasswordSet(old: oldPassword, new: newPassword)
        }
        if (oldPasswordCell.textField.text != "" || newPasswordCell.textField.text != "") && passwordChange == nil {
            showAlert(title: "Información requerida", message: "Para modificar la contraseña es necesario que ingrese la contraseña actual y la nueva.")
            return
        }
        
        viewModel.set(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: passwordChange
        )
    }
}
