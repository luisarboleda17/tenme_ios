//
//  BindableController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol Bindable: class {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bind(_ viewModel: ViewModel)
}

extension Bindable {
    func bind(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
