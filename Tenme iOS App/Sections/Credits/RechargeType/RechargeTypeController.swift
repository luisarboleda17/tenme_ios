//
//  RechargeTypeController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class RechargeTypeController: UIViewController, BindableController {
    typealias ViewModel = RechargeTypeViewModelProtocol
    
    internal var viewModel: RechargeTypeViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "Necesito plata"
    }
}
