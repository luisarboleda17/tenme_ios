//
//  Parser.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/5/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension Encodable {
    /**
     Encode AnyObject to Data
     */
    func toData() -> Data? {
        do {
            let data = try JSONEncoder().encode(self)
            return data
        } catch {
            print("Error encoding object. \(error)")
            return nil
        }
    }
}
