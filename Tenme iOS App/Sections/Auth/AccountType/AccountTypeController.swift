//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class AccountTypeController: UIViewController, BindableController {
    typealias ViewModel = AccountTypeViewModelProtocol
    
    internal var viewModel: AccountTypeViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "Tipos de cuenta"
    }
}
