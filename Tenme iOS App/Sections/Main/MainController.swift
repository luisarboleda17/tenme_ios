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
    @IBOutlet private weak var nameLbl: UILabel!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameLbl.text = viewModel.getUserName()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidLoad()
    }
    
    internal func showCloseSessionDialog() {
        OperationQueue.main.addOperation {
            let alert = UIAlertController(title: "Cerra sesión", message: "¿Estás seguro que deseas cerrar sesión?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                self.viewModel.closeSession()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: View delegate methods
    
    func loadingBalance() {
        OperationQueue.main.addOperation {
            self.balanceLbl.text = "Cargando balance..."
        }
    }
    
    func update(balance: Decimal) {
        OperationQueue.main.addOperation {
            self.balanceLbl.text = balance.toString() + " USD"
        }
    }
}
