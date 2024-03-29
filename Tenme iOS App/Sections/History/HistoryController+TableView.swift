//
//  WorkersController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension HistoryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getHistoriesNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(
            style: .subtitle,
            reuseIdentifier: "history_cell"
        )
        let history = viewModel.getHistory(atIndex: indexPath.row)
        
        switch history.type {
        case .offeredService:
            cell.textLabel?.text = "Publicó servicio en " + (history.service != nil ? history.service!.zone.name : "")
            cell.detailTextLabel?.text = "Taria/hora: " + (history.service != nil ? history.service!.hourlyRate.toString() : "") + " USD"
        case .requestedCredit:
            cell.textLabel?.text = "Crédito aprobado"
            cell.detailTextLabel?.text = history.credit != nil ? history.credit!.amount.toString() + " USD" : ""
        case .requestedService:
            if (history.user != UserSession.current.user?.id) {
                cell.textLabel?.text = (history.service?.user.fullName ?? "") + " solicitó " + (history.service?.category.name ?? "")
                cell.detailTextLabel?.text = "Zona: " + (history.service?.zone.name ?? "")
                return cell
            } else {
                cell.textLabel?.text = "Solicitó servicio en " + (history.service != nil ? history.service!.zone.name : "")
                cell.detailTextLabel?.text = "Taria/hora: " + (history.service != nil ? history.service!.hourlyRate.toString() : "") + " USD"
            }
        }
        return cell
    }
}
