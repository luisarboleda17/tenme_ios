//
//  AuthCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension AuthCoordinator {
    internal func loadSignIn() {
        OperationQueue.main.addOperation {
            if let signInController = ViewLoader.load(SignInController.self, xibName: XIBS.Controllers.signIn) {
                signInController.bind(SignInViewModel(self))
                self.navigationController.show(signInController, sender: self)
            }
        }
    }
}
