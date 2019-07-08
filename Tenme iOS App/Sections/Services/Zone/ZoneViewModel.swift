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
    
    private var zones: [Zone] = [
        Zone(id: "123", name: "Ciudad de Panamá"),
        Zone(id: "456", name: "La Chorrera")
    ]
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: ZoneControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getZones()
    }
    
    private func getZones() {
        Alamofire.request(
            API.Service.zones,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
            ).validate().responseData(
                queue: DispatchQueue.backgroundQueue,
                completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        if let zones = data.toObject(objectType: [Zone].self) {
                            self.zones = zones
                            self.viewDelegate.refreshItems()
                        } else {
                            print("Error getting categories")
                        }
                    case .failure(let error):
                        print("Error getting categories... \(error)") // TODO: Add error handler
                    }
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
