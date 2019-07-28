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
        configureView()
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Nuevo",
            style: .done,
            target: self,
            action: #selector(newMethod)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
        self.title = "Métodos de pago"
    }
    
    @objc private func newMethod() {
        
    }
    
    // MARK: - View model methods

    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
