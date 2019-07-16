//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol CountryCodeControllerProtocol {
    func refreshItems()
}

class CountryCodeController: UIViewController, BindableController, CountryCodeControllerProtocol {
    typealias ViewModel = CountryCodeViewModelProtocol
    
    internal var viewModel: CountryCodeViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Códigos de paises"
    }
    
    func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }
}
