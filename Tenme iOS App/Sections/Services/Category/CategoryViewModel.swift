//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol CategoryViewModelProtocol {
    var navDelegate: ServiceFormCoordinatorProtocol! { get set }
    
    init(_ navDelegate: ServiceFormCoordinatorProtocol)
    func getCategories() -> [Category]
    func getCategory(forIndex index: Int) -> Category
    func getCategoriesNumber() -> Int
    func select(categoryAtIndex index: Int)
}

class CategoryViewModel: CategoryViewModelProtocol {
    internal var navDelegate: ServiceFormCoordinatorProtocol!
    
    private var categories: [Category] = [
        Category(id: "123", name: "Fontanería"),
        Category(id: "456", name: "Hogar")
    ]
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getCategories() -> [Category] {
        return categories
    }
    
    func getCategory(forIndex index: Int) -> Category {
        return categories[index]
    }
    
    func getCategoriesNumber() -> Int {
        return categories.count
    }
    
    func select(categoryAtIndex index: Int) {
        navDelegate.selected(category: categories[index])
    }
}
