//
//  RechargeTypeController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension RechargeTypeController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tipo de recarga"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "recharge_type_cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = indexPath.row == 0 ? "Recarga" : "Solicitud de créditos"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.recharge()
        } else {
            viewModel.requestCredits()
        }
    }
}
