//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol PaymentMethodControllerProtocol: AlertHandlerView {
    func refreshItems()
}

class PaymentMethodController: UIViewController, BindableController, PaymentMethodControllerProtocol {
    typealias ViewModel = PaymentMethodViewModelProtocol
    
    internal var viewModel: PaymentMethodViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!
    var loadingAlert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Métodos de Pago"
    }
    
    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
