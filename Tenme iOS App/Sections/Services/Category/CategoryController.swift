//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol CategoryControllerProtocol {
    func refreshItems()
}

class CategoryController: UIViewController, BindableController, CategoryControllerProtocol {
    typealias ViewModel = CategoryViewModelProtocol
    
    internal var viewModel: CategoryViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    func refreshItems() {
        table.reloadData()
    }
}
