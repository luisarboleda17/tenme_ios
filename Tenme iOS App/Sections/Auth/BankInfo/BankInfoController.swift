//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol BankInfoControllerProtocol {
    func update(accountType: String)
    func update(bankName: String)
}

class BankInfoController: UIViewController, BindableController, TableView, BankInfoControllerProtocol {
    typealias ViewModel = BankInfoViewModelProtocol
    
    internal var viewModel: BankInfoViewModelProtocol!
    
    @IBOutlet weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerCells()
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Registrar",
            style: .done,
            target: self,
            action: #selector(signUp)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
        self.title = "Registro"
    }
    
    private func registerCells() {
        register(
            customCellWithName: Identifiers.Cells.textEdit,
            xibName: XIBS.Cells.textEdit,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.selection,
            xibName: XIBS.Cells.selection,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.optionSwitch,
            xibName: XIBS.Cells.switchCell,
            inTable: formTable
        )
    }
    
    @objc private func signUp() {
        let accountNumberCell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextEditCell
        let apcCell = formTable.cellForRow(at: IndexPath(row: 3, section: 0)) as! SwitchCell
        
        guard let accountNumberString = accountNumberCell.textField.text else {
            print("Account number not valid")
            return
        }
        guard let accountNumber = Int(accountNumberString) else {
            print("Account number not valid")
            return
        }
        guard let apcAllowed = apcCell.active else {
            print("APC not valid")
            return
        }
        
        viewModel.set(accountNumber: accountNumber, apcAllowed: apcAllowed)
        viewModel.signUp()
    }
    
    // MARK: - View delegate methods
    
    func update(accountType: String) {
        OperationQueue.main.addOperation {
            let accountTypeCell = self.formTable.cellForRow(at: IndexPath(row: 1, section: 0))
            accountTypeCell?.detailTextLabel?.text = accountType
        }
    }
    
    func update(bankName: String) {
        OperationQueue.main.addOperation {
            let bankCell = self.formTable.cellForRow(at: IndexPath(row: 0, section: 0))
            bankCell?.detailTextLabel?.text = bankName
        }
    }

}
