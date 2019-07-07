//
//  OfferServiceController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

class OfferServiceController: UIViewController, Bindable {
    typealias ViewModel = OfferServiceViewModelProtocol
    
    internal var viewModel: OfferServiceViewModelProtocol!
    
    @IBOutlet weak var categoryLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryLbl.text = viewModel.getCategoryName()
    }
}
