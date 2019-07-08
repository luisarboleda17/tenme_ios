//
//  WorkersViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol ServicesViewModelProtocol {
    var navDelegate: RequestServiceCoordinatorProtocol! { get set }
    
    init(_ navDelegate: RequestServiceCoordinatorProtocol, request: RequestServiceRequest)
    
    func getServicesNumber() -> Int
    func getService(atIndex index: Int) -> Service
    func select(service: Service)
}

class ServicesViewModel: ServicesViewModelProtocol {
    internal var navDelegate: RequestServiceCoordinatorProtocol!
    
    private var request: RequestServiceRequest!
    private var services: [Service] = [
        
    ]
    
    required init(_ navDelegate: RequestServiceCoordinatorProtocol, request: RequestServiceRequest) {
        self.navDelegate = navDelegate
        self.request = request
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
