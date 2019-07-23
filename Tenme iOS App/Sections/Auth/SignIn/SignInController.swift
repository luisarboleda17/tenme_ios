//
//  SignInView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol SignInControllerProtocol: AlertHandlerView {
    func update(countryCode: Int)
}

class SignInController: UIViewController, BindableController, SignInControllerProtocol {
    typealias ViewModel = SignInViewModelProtocol
    
    internal var viewModel: SignInViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet private weak var countryCodeBtn: UIButton!
    @IBOutlet internal weak var phoneTxt: UITextField!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(countryCode: viewModel.getDefaultCountryCode())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func facebookSignIn() {
        LoginManager().logIn(
            permissions: ["public_profile", "email"],
            from: self,
            handler: { (result, error) in
                if let error = error {
                    self.showAlert(title: "Error iniciando sesión", message: "\(error)")
                } else {
                    if let result = result,
                        let token = result.token {
                        
                        print("Getting facebook user info")
                        
                        self.viewModel.getFacebookUser(token: token.tokenString)
                    } else {
                        self.showAlert(title: "Error iniciando sesión", message: "Ha ocurrido un error desconocido")
                    }
                }
            }
        )
    }
    
    // MARK: View delegate methods
    
    func update(countryCode: Int) {
        OperationQueue.main.addOperation {
            let title = "+" + String(countryCode)
            self.countryCodeBtn.setTitle(title, for: .normal)
            self.countryCodeBtn.setTitle(title, for: .selected)
        }
    }
}
