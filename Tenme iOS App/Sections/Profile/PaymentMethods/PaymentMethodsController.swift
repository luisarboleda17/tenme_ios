//
//  WorkersController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol PaymentMethodsControllerProtocol: AlertHandlerView {
    func refreshItems()
}

class PaymentMethodsController: UIViewController, BindableController, PaymentMethodsControllerProtocol {
    typealias ViewModel = PaymentMethodsViewModelProtocol

    internal var viewModel: PaymentMethodsViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet private weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        self.title = "Métodos de pago"
    }

    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
