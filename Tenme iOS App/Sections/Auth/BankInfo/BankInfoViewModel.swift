//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol BankInfoViewModelProtocol {
    init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankInfoControllerProtocol, request: SignUpRequest)
    
    func showAccountTypes()
    func showBanks()
    
    func signUp()
    func set(bank: Bank)
    func set(accountType: BankAccountType)
    func set(accountNumber: Int, apcAllowed: Bool)
}

class BankInfoViewModel: BankInfoViewModelProtocol {
    internal var viewDelegate: BankInfoControllerProtocol!
    internal var navDelegate: AuthCoordinatorProtocol!
    
    internal var signUpRequest: SignUpRequest!
    internal var bankSelected = false
    internal var accountTypeSelected = false
    
    required init(_ navDelegate: AuthCoordinatorProtocol, viewDelegate: BankInfoControllerProtocol, request: SignUpRequest) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.signUpRequest = request
        
        self.signUpRequest.bankInfo = BankInfo()
    }
    
    func signUp() {
        guard bankSelected else {
            viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar un banco")
            return
        }
        guard accountTypeSelected else {
            viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar un tipo de cuenta")
            return
        }
        
        if let requestParams = signUpRequest.toDictionary() {
            
            self.viewDelegate.showLoading(
                loading: true,
                completion: {
                    Alamofire.request(
                        API.Auth.signUp,
                        method: .post,
                        parameters: requestParams,
                        encoding: JSONEncoding.default
                        ).responseData(
                            queue: DispatchQueue.backgroundQueue,
                            completionHandler: { response in
                                
                                self.viewDelegate.showLoading(
                                    loading: false,
                                    completion: {
                                        switch response.result {
                                        case .success(let data):
                                            
                                            // Validate status code
                                            if let statusCode = response.response?.statusCode {
                                                
                                                switch statusCode {
                                                case 200...299:
                                                    if let parsedResponse = data.toObject(objectType: SignInResponse.self) {
                                                        // Open user session
                                                        UserSession.current.open(forUser: parsedResponse.user, token: parsedResponse.token)
                                                        
                                                        // Inform coordinator that user is ready
                                                        self.navDelegate.userAuthenticated()
                                                    } else {
                                                        self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ha ocurrido un error desconocido")
                                                    }
                                                case 400:
                                                    self.viewDelegate.showAlert(title: "Información requerida", message: "Debe rellenar todos los campos para continuar")
                                                case 409:
                                                    self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ya existe un usuario con estos datos")
                                                default:
                                                    self.viewDelegate.showAlert(title: "Error registrando usuario", message: "Ha ocurrido un error desconocido")
                                                }
                                                
                                            } else {
                                                self.viewDelegate.showAlert(title: "Error registrando usuario", message: "No es posible conectarse a los servidores de Tenme")
                                            }
                                        case .failure(let error):
                                            self.viewDelegate.showAlert(title: "Error registrando usuario", message: "\(error)")
                                        }
                                }
                                )
                        }
                    )
                }
            )
        }
    }
    
    // MARK: - View model methods
    
    func showAccountTypes() {
        navDelegate.showAccountTypes()
    }
    
    func showBanks() {
        navDelegate.showBanks()
    }
    
    func set(bank: Bank) {
        signUpRequest.bankInfo?.bankId = bank.id
        viewDelegate.update(bankName: bank.name)
        bankSelected = true
    }
    
    func set(accountType: BankAccountType) {
        signUpRequest.bankInfo?.accountType = accountType
        viewDelegate.update(accountType: accountType == .saving ? "Cuenta de ahorro" : "Cuenta corriente")
        accountTypeSelected = true
    }
    
    func set(accountNumber: Int, apcAllowed: Bool) {
        signUpRequest.bankInfo?.number = accountNumber
        signUpRequest.apcAllowed = apcAllowed
    }
}

