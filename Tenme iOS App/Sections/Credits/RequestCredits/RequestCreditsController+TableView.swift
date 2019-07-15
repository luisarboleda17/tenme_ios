//
//  RequestCreditsController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension RequestCreditsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                // How much
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.textField.placeholder = "Cantidad a prestar"
                return textEditCell
            } else {
                
                // Payment Method
                let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
                selectionCell.textLabel?.text = "Forma de pago"
                selectionCell.detailTextLabel?.text = "No seleccionado"
                return selectionCell
            }
        } else {
            if indexPath.row == 0 {
                
                // Rate
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Identifiers.Cells.info)
                cell.textLabel?.text = "Intereses"
                cell.detailTextLabel?.text = "10% mensual"
                return cell
            } else {
                
                // First payment
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Identifiers.Cells.info)
                cell.textLabel?.text = "Primera letra"
                
                if let firstPaymentDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) {
                    cell.detailTextLabel?.text = firstPaymentDate.month + " " + firstPaymentDate.year
                } else {
                    cell.detailTextLabel?.text = "Desconocido."
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                // Payment methods
                viewModel.showPaymentMethods()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
