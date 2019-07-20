//
//  AlertHandlerView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/20/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol AlertHandlerView {
    func showAlert(title: String?, message: String)
}

extension AlertHandlerView where Self: UIViewController {
    /**
     Show alert on view
     */
    func showAlert(title: String?, message: String) {
        OperationQueue.main.addOperation {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "Listo",
                    style: UIAlertAction.Style.cancel,
                    handler: nil
                )
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
}
