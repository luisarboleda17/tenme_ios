//
//  AddPaymentMethodController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class AddPaymentMethodController: UIViewController, BindableController {
    typealias ViewModel = AddPaymentMethodViewModelProtocol
    
    internal var viewModel: AddPaymentMethodViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "Nuevo método de pago"
    }
}
