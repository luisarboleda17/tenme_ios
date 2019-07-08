//
//  WorkersViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol ServicesViewModelProtocol {
    init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: ServicesControllerProtocol, request: RequestServiceRequest)
    
    func getServicesNumber() -> Int
    func getService(atIndex index: Int) -> Service
    func select(service: Service)
    func viewDidLoad()
}

class ServicesViewModel: ServicesViewModelProtocol {
    internal var viewDelegate: ServicesControllerProtocol!
    internal var navDelegate: RequestServiceCoordinatorProtocol!
    
    private var request: RequestServiceRequest!
    private var services: [Service] = []
    
    required init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: ServicesControllerProtocol, request: RequestServiceRequest) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.request = request
    }
    
    func viewDidLoad() {
        getServices()
    }
    
    private func getServices() {
        Alamofire.request(
            API.Service.collectionBase,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let services = data.toObject(objectType: [Service].self) {
                            self.services = services
                            self.viewDelegate.refreshItems()
                        } else {
                            print("Error getting services")
                        }
                    case .failure(let error):
                        print("Error getting services... \(error)") // TODO: Add error handler
                    }
            }
        )
    }
    
    func getServicesNumber() -> Int {
        return services.count
    }
    
    func getService(atIndex index: Int) -> Service {
        return services[index]
    }
    
    func select(service: Service) {
        print("Selected")
    }
}
