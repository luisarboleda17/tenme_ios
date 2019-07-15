//
//  SignUpController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension SignUpController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Información de cuenta"
        } else {
            return "Información personal"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                // Country Code
                let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
                selectionCell.textLabel?.text = "Código de país"
                
                if let phone = self.viewModel.getPhone() {
                    selectionCell.isUserInteractionEnabled = false
                    selectionCell.textLabel?.isEnabled = false
                    selectionCell.detailTextLabel?.text = "+" + String(phone.countryCode)
                } else {
                    selectionCell.detailTextLabel?.text = "No seleccionado"
                }
                
                return selectionCell
            } else if indexPath.row == 1 {
                
                // Phone number
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Número de teléfono"
                
                if let phone = self.viewModel.getPhone() {
                    textEditCell.isUserInteractionEnabled = false
                    textEditCell.textField.isEnabled = false
                    textEditCell.textField.text = String(phone.phoneNumber)
                }
                
                return textEditCell
            } else if indexPath.row == 2 {
                
                // E-Mail
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Correo electrónico"
                return textEditCell
            } else {
                
                // Password
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Contraseña"
                return textEditCell
            }
        } else {
            if indexPath.row == 0 {
                
                // Id
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Identificación"
                return textEditCell
            } else if indexPath.row == 1 {
                
                // Passport
                let switchCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.optionSwitch, for: indexPath) as! SwitchCell
                switchCell.placeholder = "Es pasaporte"
                return switchCell
            } else if indexPath.row == 2 {
                
                // First Name
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Primer Nombre"
                return textEditCell
            } else {
                
                // Last name
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Apellido"
                return textEditCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                // Days
                viewModel.showDays()
            }
        } else {
            if indexPath.row == 0 {
                //Category
                viewModel.showCategories()
            } else {
                // Zone
                viewModel.showZones()
            }
        }*/
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
