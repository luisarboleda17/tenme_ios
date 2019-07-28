//
//  AddPaymentMethodController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension AddPaymentMethodController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "payment_type_cell")
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.textLabel?.text = "Tarjeta de crédito"
        } else {
            cell.textLabel?.text = "Cuenta bancaria"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.addCreditCard()
        } else {
            viewModel.addBankAccount()
        }
    }
}
