//
//  BackgroundQueue.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/6/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension DispatchQueue {
    /**
     Main background queue for api tasks
     */
    static let backgroundQueue: DispatchQueue = DispatchQueue(
        label: "com.tenme.api-queue",
        qos: .userInitiated,
        attributes: .concurrent
    )
}
