//
//  WorkersController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension PaymentMethodsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMethodsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: "payment_method_cell"
        )
        let method = viewModel.getPaymentMethod(atIndex: indexPath.row)
        
        if method.getType() == .card {
            cell.textLabel?.text = "**** " + String(method.getNumeration())
            cell.imageView?.image = UIImage(named: "Credit Card")
        } else {
            cell.textLabel?.text = String(method.getNumeration())
            cell.imageView?.image = UIImage(named: "Bank Account")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selected(methodAtIndex: indexPath.row)
    }
}
