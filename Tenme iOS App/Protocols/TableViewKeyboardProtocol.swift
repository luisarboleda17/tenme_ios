//
//  TableViewKeyboardProtocol.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/26/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol TableViewKeyboardProtocol: UITextFieldDelegate {
    var formTable: UITableView! { get set }
    var activeTextField: UITextField? { get set }
}

extension TableViewKeyboardProtocol where Self: UIViewController {
    internal func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: self.formTable.contentInset.top, left: 0, bottom: keyboardSize.height + 50, right: 0)
            self.formTable.contentInset = contentInsets
            
            // If active text field is hidden by keyboard, scroll it so it's visible
            // Your app might not need or want this behavior.
            var aRect: CGRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            let activeTextFieldRect: CGRect?
            let activeTextFieldOrigin: CGPoint?
            
            if self.activeTextField != nil {
                activeTextFieldRect = self.activeTextField?.superview?.superview?.frame
                activeTextFieldOrigin = activeTextFieldRect?.origin
                self.formTable.scrollRectToVisible(activeTextFieldRect!, animated:true)
            }
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: self.formTable.contentInset.top, left: 0, bottom: 0, right: 0)
        self.formTable.contentInset = contentInsets
        self.activeTextField = nil
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true;
    }
}
