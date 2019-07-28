//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol BankAccountFormControllerProtocol: AlertHandlerView {
    func update(accountType: String)
    func update(bankName: String)
}

class BankAccountFormController: UIViewController, BindableController, TableView, BankAccountFormControllerProtocol, TableViewKeyboardProtocol {
    typealias ViewModel = BankAccountFormViewModelProtocol
    
    internal var viewModel: BankAccountFormViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var formTable: UITableView!
    internal var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc internal func keyboardShow(notification: NSNotification) {
        keyboardWillShow(notification: notification)
    }
    
    @objc internal func keyboardHide(notification: NSNotification) {
        keyboardWillHide(notification: notification)
    }
    
    private func configureView() {
        let createButton = UIBarButtonItem(
            title: "Registrar",
            style: .done,
            target: self,
            action: #selector(create)
        )
        self.navigationItem.setRightBarButton(createButton, animated: true)
        self.title = "Cuenta bancaria"
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
    }
    
    @objc private func create() {
        let accountNumberCell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextEditCell
        
        guard let accountNumberString = accountNumberCell.textField.text, accountNumberCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir un número de cuenta")
            print("Account number not valid")
            return
        }
        guard let accountNumber = Int(accountNumberString) else {
            showAlert(title: "Información requerida", message: "Debe introducir un número de cuenta válido")
            return
        }
        
        viewModel.set(accountNumber: accountNumber)
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
