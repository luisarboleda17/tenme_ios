//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol CategoryViewModelProtocol {
    var navDelegate: PostServiceCoordinatorProtocol! { get set }
    
    init(_ navDelegate: PostServiceCoordinatorProtocol)
    func getCategories() -> [Category]
    func getCategory(forIndex index: Int) -> Category
    func getCategoriesNumber() -> Int
    func select(categoryAtIndex index: Int)
}

class CategoryViewModel: CategoryViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    
    private var categories: [Category] = [
        Category(id: "123", name: "Fontanería"),
        Category(id: "456", name: "Hogar")
    ]
    
    required init(_ navDelegate: PostServiceCoordinatorProtocol) {
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
        print("1")
        print(categories[index])
        navDelegate.selected(category: categories[index])
    }
}
