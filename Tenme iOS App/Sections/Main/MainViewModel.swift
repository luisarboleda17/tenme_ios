//
//  MainViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol MainViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: MainControllerProtocol)
    
    func viewDidLoad()
    func offerService()
    func requestService()
}

class MainViewModel: MainViewModelProtocol {
    internal var viewDelegate: MainControllerProtocol!
    internal var navDelegate: AppCoordinatorProtocol!
    
    required init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: MainControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getUserBalance()
    }
    
    private func getUserBalance() {
        viewDelegate.loadingBalance()
        Alamofire.request(
            API.User.balance,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let balanceData = data.toObject(objectType: BalanceResponse.self) {
                            self.viewDelegate.update(balance: balanceData.balance)
                        } else {
                            print("Error getting balance")
                        }
                    case .failure(let error):
                        print("Error getting balance... \(error)") // TODO: Add error handler
                    }
            }
        )
    }
    
    func offerService() {
        navDelegate.loadOfferService()
    }
    
    func requestService() {
        navDelegate.loadRequestService()
    }
}
