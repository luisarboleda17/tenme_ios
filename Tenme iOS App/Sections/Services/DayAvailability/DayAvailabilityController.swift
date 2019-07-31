//
//  DayAvailabilityController.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/31/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol DayAvailabilityControllerProtocol {
    func refreshItems()
}

class DayAvailabilityController: UIViewController, BindableController, DayAvailabilityControllerProtocol {
    typealias ViewModel = DayAvailabilityViewModelProtocol
    
    internal var viewModel: DayAvailabilityViewModelProtocol!

    @IBOutlet internal weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        let signUpButton = UIBarButtonItem(
            title: "Agregar",
            style: .done,
            target: self,
            action: #selector(addHourRange)
        )
        self.navigationItem.setRightBarButton(signUpButton, animated: true)
        self.title = "Horas disponibles"
    }
    
    @objc private func addHourRange() {
        let vc = UIViewController()
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        let editRadiusAlert = UIAlertController(title: "Selecciona un rango de hora", message: "", preferredStyle: UIAlertController.Style.alert)
        
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(
            title: "Agregar",
            style: .default,
            handler: { action in
                self.viewModel.addRange(start: pickerView.selectedRow(inComponent: 0), end: pickerView.selectedRow(inComponent: 1))
        }
        ))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        vc.view.addSubview(pickerView)
        self.present(editRadiusAlert, animated: true)
    }
    
    internal func refreshItems() {
        OperationQueue.main.addOperation {
            self.table.reloadData()
        }
    }

}
