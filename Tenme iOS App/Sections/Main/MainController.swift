//
//  MainController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class MainController: UIViewController, Bindable {
    typealias ViewModel = MainViewModelProtocol
    
    internal var viewModel: MainViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
