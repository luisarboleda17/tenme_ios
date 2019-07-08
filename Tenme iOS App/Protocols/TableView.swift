//
//  TableAdapter.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol TableView {
    func register(customCellWithName identifier: String, xibName: String, inTable table: UITableView)
}

extension TableView where Self: UIViewController {
    /**
     Register custom cell in table view
     */
    func register(customCellWithName identifier: String, xibName: String, inTable table: UITableView) {
        table.register(
            UINib(
                nibName: xibName,
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: identifier
        )
    }
}

