//
//  OfferServiceController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol OfferServiceControllerProtocol {
    func updated(categoryName: String)
}

class OfferServiceController: UIViewController, BindableController, OfferServiceControllerProtocol, TableView {
    typealias ViewModel = OfferServiceViewModelProtocol
    
    internal var viewModel: OfferServiceViewModelProtocol!
    
    @IBOutlet private weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        register(
            customCellWithName: Identifiers.Cells.textEdit,
            xibName: XIBS.Cells.textEdit,
            inTable: formTable
        )
        register(
            customCellWithName: Identifiers.Cells.selection,
            xibName: XIBS.Cells.selection,
            inTable: formTable
        )
    }
    
    func updated(categoryName: String) {
        if let cell = formTable.cellForRow(at: IndexPath(row: 0, section: 1)) {
            cell.detailTextLabel?.text = categoryName
        }
    }
}
