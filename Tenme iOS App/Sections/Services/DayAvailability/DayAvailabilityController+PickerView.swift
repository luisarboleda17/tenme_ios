//
//  DayAvailabilityController+PickerView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/31/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

extension DayAvailabilityController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row):00"
    }
}
