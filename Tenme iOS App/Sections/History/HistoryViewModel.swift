//
//  WorkersViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol HistoryViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: HistoryControllerProtocol)
    
    func getHistoriesNumber() -> Int
    func getHistory(atIndex index: Int) -> History
    func viewDidLoad()
}

class HistoryViewModel: HistoryViewModelProtocol {
    internal var viewDelegate: HistoryControllerProtocol!
    internal var navDelegate: AppCoordinatorProtocol!
    
    private var histories: [History] = []
    
    required init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: HistoryControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    private func getHistories() {
        
        viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.User.histories,
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
                                        if let histories = data.toObject(objectType: [History].self) {
                                            self.histories = histories
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error obteniendo historial", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo historial", message: "\(error)")
                                    }
                                }
                            )
                    }
                )
            }
        )
    }
    
    // MARK: - View model methods
    
    func viewDidLoad() {
        getHistories()
    }
    
    func getHistoriesNumber() -> Int {
        return histories.count
    }
    
    func getHistory(atIndex index: Int) -> History {
        return histories[index]
    }
}
