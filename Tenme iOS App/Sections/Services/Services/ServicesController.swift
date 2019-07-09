//
//  WorkersController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol ServicesControllerProtocol {
    func refreshItems()
}

class ServicesController: UIViewController, BindableController, ServicesControllerProtocol {
    typealias ViewModel = ServicesViewModelProtocol

    internal var viewModel: ServicesViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        self.title = "Servicios disponibles"
    }

    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
