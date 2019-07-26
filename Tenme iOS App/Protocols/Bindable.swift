//
//  BindableController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol BindableController: class {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bind(_ viewModel: ViewModel)
}

extension BindableController {
    func bind(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
