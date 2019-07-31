//
//  WeeklyAvailabilityController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol WeeklyAvailabilityControllerProtocol {
    func refresh(dayAtIndex index: Int)
}

class WeeklyAvailabilityController: UIViewController, TableView, BindableController, WeeklyAvailabilityControllerProtocol {
    typealias ViewModel = WeeklyAvailabilityViewModelProtocol
    
    internal var viewModel: WeeklyAvailabilityViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        self.title = "Días disponibles"
    }
    
    func refresh(dayAtIndex index: Int) {
        OperationQueue.main.addOperation {
            self.table.reloadRows(
                at: [IndexPath(row: index, section: 0)],
                with: .none
            )
        }
    }
}
