//
//  CustomAlert.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 03.06.2023.
//

import Foundation
import UIKit

class CustomAlert {
    
    static func setAlert(showIn viewController: UIViewController, textTitle: String, textMessage: String, exitButtonTitle: String?, tuplesArray: [(String, (() -> Void)?)]) {
        let alert = UIAlertController(title: textTitle, message: textMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: exitButtonTitle ?? "Cancel", style: .cancel))
        for buttonTuple in tuplesArray {
            let buttonAction = UIAlertAction(title: buttonTuple.0, style: .default) { action in
                if let complition = buttonTuple.1 {
                    complition()
                }
            }
            alert.addAction(buttonAction)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
