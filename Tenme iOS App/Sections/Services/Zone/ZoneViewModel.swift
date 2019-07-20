//
//  ZoneViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol ZoneViewModelProtocol {
    var viewDelegate: ZoneControllerProtocol! { get set }
    var navDelegate: ServiceFormCoordinatorProtocol! { get set }
    
    init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: ZoneControllerProtocol)
    func getZone(forIndex index: Int) -> Zone
    func getZonesNumber() -> Int
    func select(zoneAtIndex index: Int)
    func viewDidLoad()
}

class ZoneViewModel: ZoneViewModelProtocol {
    internal var viewDelegate: ZoneControllerProtocol!
    internal var navDelegate: ServiceFormCoordinatorProtocol!
    
    private var zones: [Zone] = []
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: ZoneControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getZones()
    }
    
    private func getZones() {
        
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Service.zones,
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
                                        if let zones = data.toObject(objectType: [Zone].self) {
                                            self.zones = zones
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error obteniendo zonas", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo zonas", message: "\(error)")
                                    }
                                }
                            )
                    }
                )
            }
        )
    }
    
    func getZone(forIndex index: Int) -> Zone {
        return zones[index]
    }
    
    func getZonesNumber() -> Int {
        return zones.count
    }
    
    func select(zoneAtIndex index: Int) {
        navDelegate.selected(zone: zones[index])
    }
}
