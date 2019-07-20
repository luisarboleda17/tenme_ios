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
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Utils.banks,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success(let data):
                                        if let banks = data.toObject(objectType: [Bank].self) {
                                            self.banks = banks
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error obteniendo bancos", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo bancos", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
            }
        )
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
