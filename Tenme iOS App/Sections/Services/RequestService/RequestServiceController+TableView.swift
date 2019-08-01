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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Category
            viewModel.showCategories()
        } else {
            // Zone
            viewModel.showZones()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
