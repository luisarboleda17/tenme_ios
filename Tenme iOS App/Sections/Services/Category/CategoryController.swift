//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol CategoryControllerProtocol: AlertHandlerView {
    func refreshItems()
}

class CategoryController: UIViewController, BindableController, CategoryControllerProtocol {
    typealias ViewModel = CategoryViewModelProtocol
    
    internal var viewModel: CategoryViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!
    internal var loadingAlert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Categorías"
    }
    
    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
