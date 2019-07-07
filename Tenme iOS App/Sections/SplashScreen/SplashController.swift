//
//  SplashController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class SplashController: UIViewController, BindableController {
    typealias ViewModel = SplashViewModelProtocol
    
    var viewModel: SplashViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loaded()
    }
}
