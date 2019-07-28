//
//  CategoryController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension PaymentMethodController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.showService() ? viewModel.getMethodsNumber() + 1 : viewModel.getMethodsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && viewModel.showService() {
            let cell = UITableViewCell(
                style: .default,
                reuseIdentifier: "payment_method"
            )
            cell.textLabel?.text = "Servicios"
            return cell
        } else {
            let method = viewModel.getPaymentMethod(forIndex: viewModel.showService() ? indexPath.row - 1 : indexPath.row)
            let cell = UITableViewCell(
                style: .subtitle,
                reuseIdentifier: "payment_method"
            )
            
            cell.textLabel?.text = method.getInformation()
            if method.getType() == .card {
                cell.detailTextLabel?.text = "**** " + String(method.getNumeration())
                cell.imageView?.image = UIImage(named: "Credit Card")
            } else {
                cell.detailTextLabel?.text = String(method.getNumeration())
                cell.imageView?.image = UIImage(named: "Bank Account")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(methodAtIndex: indexPath.row)
    }
}
