//
//  PasswordView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class PasswordController: UIViewController, Bindable {
    typealias ViewModel = PasswordViewModelProtocol
    
    internal var viewModel: PasswordViewModelProtocol!
    
    @IBOutlet weak var passwordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
