//
//  Data+File.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/17/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension Data {
    static func from(fileAtUrl url: String, fileExtension: String) -> Data? {
        guard let path = Bundle.main.path(forResource: url, ofType: fileExtension) else {
            print("Error getting path")
            return nil
        }
        
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        } catch let error {
            print(error)
            return nil
        }
    }
}
