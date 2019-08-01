//
//  SignUpController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: AlertHandlerView {}

class ProfileViewController: UIViewController, BindableController, TableView, ProfileViewControllerProtocol {
    typealias ViewModel = ProfileViewModelProtocol
    
    internal var viewModel: ProfileViewModelProtocol!
    internal var loadingAlert: UIAlertController?
    
    @IBOutlet weak var formTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "Mi perfil"
    }
}
