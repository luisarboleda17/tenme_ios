//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol BankControllerProtocol: AlertHandlerView {
    func refreshItems()
}

class BankController: UIViewController, BindableController, BankControllerProtocol {
    typealias ViewModel = BankViewModelProtocol
    
    internal var viewModel: BankViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Bancos"
    }
    
    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
