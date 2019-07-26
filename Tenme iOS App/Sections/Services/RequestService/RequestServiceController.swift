//
//  OfferServiceController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol RequestServiceControllerProtocol: AlertHandlerView {
    func updated(categoryName: String)
    func updated(zoneName: String)
    func updated(weeklyAvailabilityNames: String)
}

class RequestServiceController: UIViewController, BindableController, RequestServiceControllerProtocol, TableView, TableViewKeyboardProtocol {
    typealias ViewModel = RequestServiceViewModelProtocol
    
    internal var viewModel: RequestServiceViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet internal weak var formTable: UITableView!
    internal var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc internal func keyboardShow(notification: NSNotification) {
        keyboardWillShow(notification: notification)
    }
    
    @objc internal func keyboardHide(notification: NSNotification) {
        keyboardWillHide(notification: notification)
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
            title: "Buscar",
            style: .done,
            target: self,
            action: #selector(requestService)
        )
        self.navigationItem.setRightBarButton(offerButton, animated: true)
        self.title = "Necesito un servicio"
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
    
    @objc func requestService() {
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
        
        viewModel.requestService(dailyHours: parsedDailyHours, hourlyRate: parsedHourlyRate)
    }
}
