//
//  WorkersViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol ServicesViewModelProtocol {
    init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: ServicesControllerProtocol, request: RequestServiceRequest)
    
    func getServicesNumber() -> Int
    func getService(atIndex index: Int) -> Service
    func selected(serviceAtIndex index: Int)
    func viewDidLoad()
}

class ServicesViewModel: ServicesViewModelProtocol {
    internal var viewDelegate: ServicesControllerProtocol!
    internal var navDelegate: RequestServiceCoordinatorProtocol!
    
    private var request: RequestServiceRequest!
    private var services: [Service] = []
    
    required init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: ServicesControllerProtocol, request: RequestServiceRequest) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.request = request
    }
    
    func viewDidLoad() {
        getServices()
    }
    
    private func getServices() {
        
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Service.collectionBase,
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
                                        if let services = data.toObject(objectType: [Service].self) {
                                            self.services = services
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error guardando servicio", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo servicios", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
            }
        )
    }
    
    func getServicesNumber() -> Int {
        return services.count
    }
    
    func getService(atIndex index: Int) -> Service {
        return services[index]
    }
    
    func selected(serviceAtIndex index: Int) {
        let service = services[index]
        
        if let params = request.toDictionary(){
            
            self.viewDelegate.showLoading(
                loading: true,
                completion: {
                    Alamofire.request(
                        API.Service.collectionBase + "/" + service.id + "/request",
                        method: .post,
                        parameters: params,
                        encoding: JSONEncoding.default,
                        headers: [
                            "Authorization": "Bearer " + (UserSession.current.token ?? "")
                        ]
                        ).responseData(
                            queue: DispatchQueue.backgroundQueue,
                            completionHandler: { response in
                                self.viewDelegate.showLoading(
                                    loading: false,
                                    completion: {
                                        switch response.result {
                                        case .success:
                                            
                                            // Validate status code
                                            if let statusCode = response.response?.statusCode {
                                                
                                                switch statusCode {
                                                case 200...299:
                                                    self.viewDelegate.showAlert(
                                                        title: "Servicio solicitado",
                                                        message: "Puede ver información del servicio solicitado visualizando el Historial",
                                                        completion: { _ in
                                                            self.navDelegate.serviceRequested()
                                                        }
                                                    )
                                                case 400:
                                                    self.viewDelegate.showAlert(title: "Saldo insuficiente", message: "No cuenta con saldo suficiente para solicitar este servicio")
                                                default:
                                                    self.viewDelegate.showAlert(title: "Error seleccionando servicio", message: "Ha ocurrido un error desconocido")
                                                }
                                                
                                            } else {
                                                self.viewDelegate.showAlert(title: "Error seleccionando servicio", message: "No es posible conectarse a los servidores de Tenme")
                                            }
                                        case .failure(let error):
                                            self.viewDelegate.showAlert(title: "Error seleccionando servicio", message: "\(error)")
                                        }
                                    }
                                )
                        }
                    )
                }
            )
        }
    }
}
