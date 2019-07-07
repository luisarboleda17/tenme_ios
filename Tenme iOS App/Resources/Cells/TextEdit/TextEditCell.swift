//
//  TextEditCell.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class TextEditCell: UITableViewCell {
    
    @IBOutlet private weak var textField: UITextField!
    
    var placeholder: String? {
        didSet {
            self.textField.placeholder = placeholder
        }
    }
    
    var fieldText: String? {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = fieldText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
