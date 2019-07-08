//
//  MainController+Events.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension MainController {
    @IBAction func offerBtnTouched(_ sender: Any) {
        viewModel.offerService()
    }
    
    @IBAction func requestServiceBtnTouched(_ sender: Any) {
        viewModel.requestService()
    }
}
