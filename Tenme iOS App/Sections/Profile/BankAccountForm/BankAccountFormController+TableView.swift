//
//  SignUpController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension BankAccountFormController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Información bancaria"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            // Bank
            let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
            selectionCell.textLabel?.text = "Banco"
            selectionCell.detailTextLabel?.text = "No seleccionado"
            return selectionCell
        } else if indexPath.row == 1 {
            
            // Account Type
            let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
            selectionCell.textLabel?.text = "Tipo de cuenta"
            selectionCell.detailTextLabel?.text = "No seleccionado"
            return selectionCell
        } else {
            
            // Account number
            let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
            textEditCell.textField.placeholder = "Número de cuenta"
            textEditCell.textField.keyboardType = .numberPad
            return textEditCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Bank
                viewModel.showBanks()
            } else if indexPath.row == 1 {
                // Account type
                viewModel.showAccountTypes()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
