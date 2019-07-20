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
    
    @IBAction func requestCreditsBtnTouched(_ sender: Any) {
        viewModel.requestCredits()
    }
    
    @IBAction func historyBtnTouched(_ sender: Any) {
        viewModel.loadHistories()
    }
    
    @IBAction func closeSessionBtnTouched(_ sender: Any) {
        viewModel.closeSession()
    }
}
