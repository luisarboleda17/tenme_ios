//
//  CategoryController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class PaymentMethodController: UIViewController, BindableController {
    typealias ViewModel = PaymentMethodViewModelProtocol
    
    internal var viewModel: PaymentMethodViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "Métodos de Pago"
    }
}
