//
//  SignInView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    internal var viewModel: SignInViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(_ viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
    }
}
