//
//  WorkersController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension ServicesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getServicesNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(
            style: .subtitle,
            reuseIdentifier: "service_cell"
        )
        let service = viewModel.getService(atIndex: indexPath.row)
        
        cell.textLabel?.text = service.user.fullName
        cell.detailTextLabel?.text = "Precio/hora:" + String(service.hourlyRate) + " - Puntaje: " + String(service.user.score)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selected(serviceAtIndex: indexPath.row)
    }
}
