//
//  ZoneController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol ZoneControllerProtocol {
    func refreshItems()
}

class ZoneController: UIViewController, BindableController, ZoneControllerProtocol {
    typealias ViewModel = ZoneViewModelProtocol
    
    internal var viewModel: ZoneViewModelProtocol!
    
    @IBOutlet private weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    func refreshItems() {
        table.reloadData()
    }
}
