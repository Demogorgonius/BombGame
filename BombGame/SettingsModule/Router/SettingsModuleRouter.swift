//
//  SettingsModuleRouter.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation
import UIKit
protocol SettingsModuleRouterProtocol: AnyObject {

    func goToStartScreen()
    
}

class SettingsModuleRouter: SettingsModuleRouterProtocol {
    
    weak var view: UIViewController?
    
    func goToStartScreen() {
        
        self.view?.navigationController?.popViewController(animated: true)
        
    }
    
}
