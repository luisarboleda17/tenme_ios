//
//  SignInView.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class SignInController: UIViewController, BindableController, UIPickerViewDelegate, UIPickerViewDataSource {
    typealias ViewModel = SignInViewModelProtocol
    
    internal var viewModel: SignInViewModelProtocol!
    
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    let countries = [507, 506, 505]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let countryCodePicker = UIPickerView()
        countryCodePicker.delegate = self
        countryCodePicker.dataSource = self
        self.countryCodeTxt.inputView = countryCodePicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(countries[row])
    }
}
