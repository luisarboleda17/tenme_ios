//
//  WorkersController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol HistoryControllerProtocol {
    func refreshItems()
}

class HistoryController: UIViewController, BindableController, HistoryControllerProtocol {
    typealias ViewModel = HistoryViewModelProtocol

    internal var viewModel: HistoryViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        self.title = "Historial"
    }

    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
