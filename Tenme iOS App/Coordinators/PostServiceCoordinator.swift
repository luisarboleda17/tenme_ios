//
//  PostServiceCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol PostServiceCoordinatorProtocol: Coordinator {
    var parentDelegate: AppCoordinatorProtocol! { get set }
    var navigationController: UINavigationController! { get set }
    
    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func selected(category: Category)
}

class PostServiceCoordinator: PostServiceCoordinatorProtocol {
    internal let TAG = "POST SERVICE COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadCategoryView()
    }
    
    func selected(category: Category) {
        loadOfferService(category: category)
    }
}
