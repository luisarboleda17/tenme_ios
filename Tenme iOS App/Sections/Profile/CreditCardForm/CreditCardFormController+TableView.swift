//
//  SignUpController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension CreditCardFormController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Información de tarjeta de crédito" : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                // Cardholder name
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Nombre en tarjeta"
                textEditCell.textField.textContentType = .name
                return textEditCell
            } else if indexPath.row == 1 {
                
                // Credit card number
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Número de tarjeta"
                textEditCell.textField.textContentType = .creditCardNumber
                textEditCell.textField.keyboardType = .numberPad
                return textEditCell
            } else if indexPath.row == 2 {
                
                // Expiration Month
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Mes de vencimiento"
                textEditCell.textField.keyboardType = .numberPad
                return textEditCell
            } else {
                
                // Expiration Year
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Año de vencimiento"
                textEditCell.textField.keyboardType = .numberPad
                return textEditCell
            }
        } else {
            // CVV
            let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
            textEditCell.textField.placeholder = "Código de seguridad"
            textEditCell.textField.keyboardType = .numberPad
            return textEditCell
        }
    }
}
