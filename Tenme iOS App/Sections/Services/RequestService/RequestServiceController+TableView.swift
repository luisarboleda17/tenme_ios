//
//  OfferServiceController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension RequestServiceController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                // Daily hours
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.placeholder = "Horas diarias"
                return textEditCell
            } else if indexPath.row == 1 {
                
                // Hourly rate
                let textEditCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.textEdit, for: indexPath) as! TextEditCell
                textEditCell.placeholder = "Precio por hora"
                return textEditCell
            } else {
                // Days
                let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
                selectionCell.textLabel?.text = "Días disponibles"
                selectionCell.detailTextLabel?.text = "No seleccionados"
                return selectionCell
            }
        } else {
            if indexPath.row == 0 {
                
                // Category
                let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
                selectionCell.textLabel?.text = "Categoría"
                selectionCell.detailTextLabel?.text = "No seleccionada"
                return selectionCell
            } else {
                
                // Zone
                let selectionCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.selection, for: indexPath)
                selectionCell.textLabel?.text = "Zona"
                selectionCell.detailTextLabel?.text = "No seleccionada"
                return selectionCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                // Days
                viewModel.showDays()
            }
        } else {
            if indexPath.row == 0 {
                //Category
                viewModel.showCategories()
            } else {
                // Zone
                viewModel.showZones()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
