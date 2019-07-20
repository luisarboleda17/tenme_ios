//
//  AlertHandlerView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/20/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol AlertHandlerView: class {
    var loadingAlert: UIAlertController? { get set }
    
    func showAlert(title: String?, message: String)
    func showAlert(title: String?, message: String, completion: ((UIAlertAction) -> Void)?)
    func showLoading(loading: Bool, completion: (() -> ())?)
}

extension AlertHandlerView where Self: UIViewController {
    /**
     Show alert on view
     */
    func showAlert(title: String?, message: String) {
        self.showAlert(title: title, message: message, completion: nil)
    }
    
    func showAlert(title: String?, message: String, completion: ((UIAlertAction) -> Void)?) {
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
                    handler: completion
                )
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoading(loading: Bool, completion: (() -> ())?) {
        OperationQueue.main.addOperation {
            if loading {
                let alert = UIAlertController(title: nil, message: "Por favor espera...", preferredStyle: .alert)
                
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();
                
                alert.view.addSubview(loadingIndicator)
                self.loadingAlert = alert
                self.present(alert, animated: true, completion: completion)
            } else {
                if let alert = self.loadingAlert {
                    alert.dismiss(animated: true, completion: completion)
                }
            }
        }
    }
}
