//
//  SwitchCell.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    
    @IBOutlet private weak var placeholderLbl: UILabel!
    @IBOutlet private weak var optionSwitch: UISwitch!
    
    var placeholder: String? {
        didSet {
            self.placeholderLbl.text = placeholder
        }
    }
    
    var active: Bool? {
        get {
            return self.optionSwitch.isOn
        }
        set {
            self.optionSwitch.isOn = active ?? false
        }
    }
}
