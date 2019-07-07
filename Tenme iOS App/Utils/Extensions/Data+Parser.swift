//
//  Codable+Data.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/5/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension Data {
    
    /**
     Decode Data to AnyObject
     */
    func toObject<T: Decodable>(objectType: T.Type) -> T? {
        do {
            let object = try JSONDecoder().decode(objectType.self, from: self)
            return object
        } catch {
            print("Error decoding object. \(error)")
            return nil
        }
    }
}
