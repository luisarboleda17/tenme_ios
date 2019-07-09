//
//  SignInView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol SignInControllerProtocol {
    func update(countryCode: Int)
}

class SignInController: UIViewController, BindableController, SignInControllerProtocol {
    typealias ViewModel = SignInViewModelProtocol
    
    internal var viewModel: SignInViewModelProtocol!
    
    @IBOutlet private weak var countryCodeTxt: UITextField!
    @IBOutlet internal weak var phoneTxt: UITextField!
    internal var countryPickerView: UIPickerView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryPickerView = UIPickerView()
        configurePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configurePickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryCodeTxt.inputView = countryPickerView
    }
    
    // MARK: View delegate methods
    
    func update(countryCode: Int) {
        OperationQueue.main.addOperation {
            self.countryCodeTxt.text = "+" + String(countryCode)
        }
    }
}
