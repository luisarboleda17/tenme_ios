//
//  SignUpController+Events.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension SignUpController {
    @IBAction func signBtnTouched(_ sender: Any) {
        viewModel.signUp()
    }
}
