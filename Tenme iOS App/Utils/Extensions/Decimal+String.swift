//
//  Decimal+String.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/8/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension Decimal {
    func toString() -> String {
        return NSDecimalNumber(decimal: self).stringValue
    }
}
