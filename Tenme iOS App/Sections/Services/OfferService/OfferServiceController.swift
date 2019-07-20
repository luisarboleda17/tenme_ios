//
//  OfferServiceController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol OfferServiceControllerProtocol: AlertHandlerView {
    func updated(categoryName: String)
    func updated(zoneName: String)
    func updated(weeklyAvailabilityNames: String)
}

class OfferServiceController: UIViewController, BindableController, OfferServiceControllerProtocol, TableView {
    typealias ViewModel = OfferServiceViewModelProtocol
    
    internal var viewModel: OfferServiceViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet private weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerCells()
    }
    
    private func registerCells() {
        register(
            customCellWithName: Identifiers.Cells.textEdit,
            xibName: XIBS.Cells.textEdit,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.selection,
            xibName: XIBS.Cells.selection,
            inTable: formTable
        )
    }
    
    private func configureView() {
        let offerButton = UIBarButtonItem(
            title: "Ofrecer",
            style: .done,
            target: self,
            action: #selector(offerService)
        )
        self.navigationItem.setRightBarButton(offerButton, animated: true)
        self.title = "Ofrezco servicio"
    }
    
    func updated(categoryName: String) {
        if let cell = formTable.cellForRow(at: IndexPath(row: 0, section: 1)) {
            cell.detailTextLabel?.text = categoryName
        }
    }
    
    func updated(zoneName: String) {
        if let cell = formTable.cellForRow(at: IndexPath(row: 1, section: 1)) {
            cell.detailTextLabel?.text = zoneName
        }
    }
    
    func updated(weeklyAvailabilityNames: String) {
        if let cell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) {
            cell.detailTextLabel?.text = weeklyAvailabilityNames
        }
    }
    
    @objc func offerService() {
        let dailyHoursCell = formTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextEditCell
        let hourlyRateCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextEditCell
        
        guard let rawDailyHours = dailyHoursCell.textField.text, dailyHoursCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir la cantidad de horas diarias")
            return
        }
        guard let parsedDailyHours = Int(rawDailyHours) else {
            showAlert(title: "Información requerida", message: "Debe introducir una cantidad de horas diarias válida")
            return
        }
        guard let rawHourlyRate = hourlyRateCell.textField.text, hourlyRateCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el precio por hora de servicio")
            return
        }
        guard let parsedHourlyRate = Double(rawHourlyRate) else {
            showAlert(title: "Información requerida", message: "Debe introducir un precio por hora de servicio válido")
            return
        }
        
        viewModel.postService(dailyHours: parsedDailyHours, hourlyRate: parsedHourlyRate)
    }
}
