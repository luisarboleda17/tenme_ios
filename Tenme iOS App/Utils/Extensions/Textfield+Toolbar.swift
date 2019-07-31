//
//  Textfield+Toolbar.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/26/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension UITextField {
    func useToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        toolbar.setItems(
            [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onPressDone))
            ],
            animated: false
        )
        if let color = UIColor(named: "Primary") {
            toolbar.tintColor = color
        }
        
        self.inputAccessoryView = toolbar
    }
    
    @objc private func onPressDone() {
        self.endEditing(true)
    }
}
