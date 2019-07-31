//
//  ServiceFormViewModelProtocol.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol ServiceFormCoordinatorProtocol {
    func showCategories()
    func showZones()
    func showDays(availability: WeeklyAvailability?)
    func selected(category: Category)
    func selected(zone: Zone)
    func selected(weeklyAvailability: WeeklyAvailability)
}
