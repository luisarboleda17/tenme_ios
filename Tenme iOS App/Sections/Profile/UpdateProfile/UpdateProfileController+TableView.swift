//
//  SignUpController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension UpdateProfileController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Información personal"
        } else {
            return "Información de cuenta"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                // First Name
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = viewModel.getFirstName() ?? "Primer Nombre"
                textEditCell.textField.textContentType = .name
                
                return textEditCell
            } else if indexPath.row == 1 {
                
                // Last name
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = viewModel.getLastName() ?? "Apellido"
                textEditCell.textField.textContentType = .familyName
                
                return textEditCell
            } else {
                
                // E-Mail
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = viewModel.getEmail() ?? "Correo electrónico"
                textEditCell.textField.keyboardType = .emailAddress
                textEditCell.textField.textContentType = .emailAddress
                
                return textEditCell
            }
        } else {
            if indexPath.row == 0 {
                
                // Old Password
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Contraseña actual"
                textEditCell.textField.textContentType = .password
                textEditCell.textField.isSecureTextEntry = true
                
                return textEditCell
            } else {
                
                // New Password
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Nueva contraseña"
                textEditCell.textField.textContentType = .password
                textEditCell.textField.isSecureTextEntry = true
                
                return textEditCell
            }
        }
    }
}
