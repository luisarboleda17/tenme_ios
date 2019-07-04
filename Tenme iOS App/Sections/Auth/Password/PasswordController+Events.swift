//
//  PasswordController+Events.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension PasswordController {
    @IBAction func signBtnTouched(_ sender: Any) {
        if let password = self.passwordTxt?.text {
            self.viewModel.signIn(password: password)
        }
    }
}
