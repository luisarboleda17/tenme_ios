//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol BankViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankControllerProtocol)
    
    func getBank(forIndex index: Int) -> Bank
    func getBanksNumber() -> Int
    func select(bankAtIndex index: Int)
    func viewDidLoad()
}

class BankViewModel: BankViewModelProtocol {
    internal var viewDelegate: BankControllerProtocol!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    private var banks: [Bank] = []
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getBanks()
    }
    
    private func getBanks() {
        /*
        Alamofire.request(
            API.Service.categories,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
        ).validate().responseData(
            queue: DispatchQueue.backgroundQueue,
            completionHandler: { response in
                switch response.result {
                case .success(let data):
                    if let categories = data.toObject(objectType: [Category].self) {
                        self.categories = categories
                        self.viewDelegate.refreshItems()
                    } else {
                        print("Error getting categories")
                    }
                case .failure(let error):
                    print("Error getting categories... \(error)") // TODO: Add error handler
                }
            }
        )*/
        banks = [
            Bank(id: "1", name: "Banco General"),
            Bank(id: "2", name: "Banco Azteca")
        ]
    }
    
    func getBank(forIndex index: Int) -> Bank {
        return banks[index]
    }
    
    func getBanksNumber() -> Int {
        return banks.count
    }
    
    func select(bankAtIndex index: Int) {
        navDelegate.selected(bank: banks[index])
    }
}
