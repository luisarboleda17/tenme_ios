//
//  SignUpController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "profile_cell")
            cell.imageView?.image = UIImage(named: "User")
            
            if let fName = UserSession.current.user?.firstName, let lName = UserSession.current.user?.lastName {
                cell.textLabel?.text = "\(fName) \(lName)"
            } else {
                cell.textLabel?.text =  "Nombre desconocido"
            }
            
            cell.detailTextLabel?.text = viewModel.getBalance().toString() + " USD"
            
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "action_cell")
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Actualizar perfil"
            } else {
                cell.textLabel?.text = "Métodos de pago"
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // Update profile
                viewModel.updateProfile()
            } else {
                // Manage payment methods
                viewModel.managePaymentMethods()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
