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
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
