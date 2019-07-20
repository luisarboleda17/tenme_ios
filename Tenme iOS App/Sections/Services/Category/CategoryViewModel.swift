//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol CategoryViewModelProtocol {
    var viewDelegate: CategoryControllerProtocol! { get set }
    var navDelegate: ServiceFormCoordinatorProtocol! { get set }
    
    init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: CategoryControllerProtocol)
    func getCategory(forIndex index: Int) -> Category
    func getCategoriesNumber() -> Int
    func select(categoryAtIndex index: Int)
    func viewDidLoad()
}

class CategoryViewModel: CategoryViewModelProtocol {
    internal var viewDelegate: CategoryControllerProtocol!
    internal var navDelegate: ServiceFormCoordinatorProtocol!
    
    private var categories: [Category] = []
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: CategoryControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getCategories()
    }
    
    private func getCategories() {
        
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Service.categories,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success(let data):
                                        if let categories = data.toObject(objectType: [Category].self) {
                                            self.categories = categories
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error obteniendo categorias", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo categorias", message: "\(error)")
                                    }
                                }
                            )
                    }
                )
            }
        )
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
