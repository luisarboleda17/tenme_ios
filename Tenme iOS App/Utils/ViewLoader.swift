//
//  ViewLoader.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class ViewLoader {
    /**
     Initialize any view controller in main bundle
    */
    static func load<V: UIViewController>(_ viewController: V.Type, xibName: String) -> V? {
        return viewController.init(nibName: xibName, bundle: Bundle.main)
    }
}
