//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    
    var navigationController: UINavigationController {get set}
    
    func getStartViewController() -> UIViewController
    
    func handleAction(actionType: CoordinatorActionProtocol)
}

protocol CoordinatorActionProtocol {
    
}
