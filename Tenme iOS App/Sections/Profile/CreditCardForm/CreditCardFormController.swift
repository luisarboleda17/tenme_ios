//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol CreditCardFormControllerProtocol: AlertHandlerView {}

class CreditCardFormController: UIViewController, BindableController, TableView, CreditCardFormControllerProtocol, TableViewKeyboardProtocol {
    typealias ViewModel = CreditCardFormViewModelProtocol
    
    internal var viewModel: CreditCardFormViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var formTable: UITableView!
    var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureView()
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
        self.title = "Tarjeta de crédito"
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
        let cardNameCell = formTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextEditCell
        let cardNumberCell = formTable.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextEditCell
        let expirationMonthCell = formTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextEditCell
        let expirationYearCell = formTable.cellForRow(at: IndexPath(row: 3, section: 0)) as! TextEditCell
        let cvvCell = formTable.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextEditCell
        
        guard let cardName = cardNameCell.textField.text, cardNameCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el nombre del titular")
            return
        }
        guard let cardNumber = cardNumberCell.textField.text, cardNumberCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el número de la tarjeta")
            return
        }
        guard let parsedCardNumber = Int(cardNumber) else {
            showAlert(title: "Información requerida", message: "Debe introducir un número de tarjeta válido")
            return
        }
        guard let expirationMonth = expirationMonthCell.textField.text, expirationMonthCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el mes de vencimiento")
            return
        }
        guard let parsedExpirationMonth = Int(expirationMonth) else {
            showAlert(title: "Información requerida", message: "Debe introducir un mes de vencimiento válido")
            return
        }
        guard let expirationYear = expirationYearCell.textField.text, expirationYearCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el año de vencimiento")
            return
        }
        guard let parsedExpirationYear = Int(expirationYear) else {
            showAlert(title: "Información requerida", message: "Debe introducir un año de vencimiento válido")
            return
        }
        guard let cvv = cvvCell.textField.text, cvvCell.textField.text != "" else {
            showAlert(title: "Información requerida", message: "Debe introducir el código de verificación")
            return
        }
        guard let parsedCVV = Int(cvv) else {
            showAlert(title: "Información requerida", message: "Debe introducir código de verificación válido")
            return
        }
        
        viewModel.set(
            name: cardName,
            number: parsedCardNumber,
            expirationMonth: parsedExpirationMonth,
            expirationYear: parsedExpirationYear,
            cvv: parsedCVV
        )
    }
}
