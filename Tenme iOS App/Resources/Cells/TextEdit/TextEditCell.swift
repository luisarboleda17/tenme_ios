//
//  TextEditCell.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class TextEditCell: UITableViewCell {
    
    @IBOutlet public weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.useToolbar()
    }
}
