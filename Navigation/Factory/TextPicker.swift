//
//  TextPicker.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 01.12.2022.
//

import Foundation

import UIKit

class TextPicker {
    static let defaultPicker = TextPicker()
    
    func getText(showIn viewController: UIViewController, title: String?, placeholder: String?, completion: ((_ text: String)->Void)?) {
        let titleText = title ?? "enter_text".localized
        let placeholderText = placeholder ?? "enter_text".localized
        let alertController = UIAlertController(title: titleText, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholderText
        }
        
        let actionAdd = UIAlertAction(title: "ОК", style: .default) { action in
            if let text = alertController.textFields?[0].text,
               text != "" {
                completion?(text)
            }
        }
        let actionCancel = UIAlertAction(title: "cancel".localized, style: .cancel)
        
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
}
