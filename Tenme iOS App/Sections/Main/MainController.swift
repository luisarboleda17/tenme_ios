//
//  MainController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol MainControllerProtocol {
    func update(balance: Decimal)
    func loadingBalance()
}

class MainController: UIViewController, BindableController, MainControllerProtocol {
    typealias ViewModel = MainViewModelProtocol
    
    internal var viewModel: MainViewModelProtocol!
    
    @IBOutlet private weak var balanceLbl: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
    }
    
    func loadingBalance() {
        OperationQueue.main.addOperation {
            self.balanceLbl.text = "Cargando balance..."
        }
    }
    
    func update(balance: Decimal) {
        OperationQueue.main.addOperation {
            self.balanceLbl.text = balance.toString()
        }
    }
}
