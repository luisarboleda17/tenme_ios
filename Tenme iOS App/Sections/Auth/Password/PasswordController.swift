//
//  PasswordView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class PasswordController: UIViewController, BindableController, AlertHandlerView {
    typealias ViewModel = PasswordViewModelProtocol
    
    internal var viewModel: PasswordViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var passwordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        let offerButton = UIBarButtonItem(
            title: "Continuar",
            style: .done,
            target: self,
            action: #selector(signIn)
        )
        self.navigationItem.setRightBarButton(offerButton, animated: true)
        self.title = "Contraseña"
    }
    
    @objc internal func signIn() {
        if let password = self.passwordTxt?.text {
            self.viewModel.signIn(password: password)
        }
    }
}
