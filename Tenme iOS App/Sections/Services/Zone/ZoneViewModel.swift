//
//  ZoneViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol ZoneViewModelProtocol {
    var navDelegate: ServiceFormCoordinatorProtocol! { get set }
    
    init(_ navDelegate: ServiceFormCoordinatorProtocol)
    func getZones() -> [Zone]
    func getZone(forIndex index: Int) -> Zone
    func getZonesNumber() -> Int
    func select(zoneAtIndex index: Int)
}

class ZoneViewModel: ZoneViewModelProtocol {
    internal var navDelegate: ServiceFormCoordinatorProtocol!
    
    private var zones: [Zone] = [
        Zone(id: "123", name: "Ciudad de Panamá"),
        Zone(id: "456", name: "La Chorrera")
    ]
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getZones() -> [Zone] {
        return zones
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
