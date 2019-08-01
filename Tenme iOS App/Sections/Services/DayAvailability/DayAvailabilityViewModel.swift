//
//  DayAvailabilityViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/31/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol DayAvailabilityViewModelProtocol {
    init (navDelegate: PostServiceCoordinatorProtocol, viewDelegate: DayAvailabilityControllerProtocol, ranges: [DayAvailabilityRange])
    
    func getRangesNumber() -> Int
    func get(rangeAtIndex index: Int) -> DayAvailabilityRange
    func addRange(start: Int, end: Int)
    func delete(rangeAtIndex index: Int)
}

class DayAvailabilityViewModel: DayAvailabilityViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    internal var viewDelegate: DayAvailabilityControllerProtocol!
    
    internal var ranges: [DayAvailabilityRange] = []
    
    required init(navDelegate: PostServiceCoordinatorProtocol, viewDelegate: DayAvailabilityControllerProtocol, ranges: [DayAvailabilityRange]) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.ranges = ranges
    }
    
    func getRangesNumber() -> Int {
        return ranges.count
    }
    
    func get(rangeAtIndex index: Int) -> DayAvailabilityRange {
        return ranges[index]
    }
    
    func addRange(start: Int, end: Int) {
        self.ranges.append(DayAvailabilityRange(startHour: start, endHour: end))
        self.viewDelegate.refreshItems()
        self.navDelegate.selected(ranges: ranges)
    }
    
    func delete(rangeAtIndex index: Int) {
        self.ranges.remove(at: index)
        self.viewDelegate.refreshItems()
        self.navDelegate.selected(ranges: ranges)
    }
}
