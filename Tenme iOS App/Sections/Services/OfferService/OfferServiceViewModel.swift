//
//  OfferServiceViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol OfferServiceViewModelProtocol {
    var navDelegate: PostServiceCoordinatorProtocol! { get set }
    
    init(_ navDelegate: PostServiceCoordinatorProtocol, category: Category)
    
    func getCategoryName() -> String
}

class OfferServiceViewModel: OfferServiceViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    
    private var category: Category!
    
    required init(_ navDelegate: PostServiceCoordinatorProtocol, category: Category) {
        self.navDelegate = navDelegate
        self.category = category
    }
    
    func getCategoryName() -> String {
        return category.name
    }
}
