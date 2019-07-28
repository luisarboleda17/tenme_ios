//
//  RequestCreditsController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/13/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol RequestCreditsControllerProtocol: AlertHandlerView {
    func update(paymentMethod: String)
}

class RequestCreditsController: UIViewController, BindableController, RequestCreditsControllerProtocol, TableView {
    typealias ViewModel = RequestCreditsViewModelProtocol
    
    internal var viewModel: RequestCreditsViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet internal weak var formTable: UITableView!

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
            title: viewModel.getMainButtonTitle(),
            style: .done,
            target: self,
            action: #selector(requestCredits)
        )
        self.navigationItem.setRightBarButton(offerButton, animated: true)
        self.title = viewModel.getTitle()
    }
    
    @objc func requestCredits() {
        let amountCell = self.formTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextEditCell
        
        if let amountString = amountCell.textField.text,
            let amount = Decimal(string: amountString) {
            viewModel.request(amount: amount)
        } else {
            showAlert(title: "Información requerida", message: "Debe introducir una cantidad válida")
        }
    }
    
    // MARK: - View delegate methods
    
    func update(paymentMethod: String) {
        OperationQueue.main.addOperation {
            if let cell = self.formTable.cellForRow(at: IndexPath(row: 1, section: 0)) {
                cell.detailTextLabel?.text = paymentMethod
            }
        }
    }
}
