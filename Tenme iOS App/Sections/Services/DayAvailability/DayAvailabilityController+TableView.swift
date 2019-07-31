//
//  DayAvailabilityController+TableView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/31/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension DayAvailabilityController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRangesNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hour_cell")
        let range = viewModel.get(rangeAtIndex: indexPath.row)
        cell.textLabel?.text = "\(String(range.startHour)):00 - \(String(range.endHour)):00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OperationQueue.main.addOperation {
            let alert = UIAlertController(
                title: "Elimiar rango de hora",
                message: "¿Seguro que deseas eliminar este rango de hora?",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "Remover",
                    style: .destructive,
                    handler: { action in
                        self.viewModel.delete(rangeAtIndex: indexPath.row)
                }
                )
            )
            alert.addAction(
                UIAlertAction(
                    title: "Canccelar",
                    style: .cancel,
                    handler: nil
                )
            )
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
