//
//  SettingsModuleRouter.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation

protocol SettingsModuleRouterProtocol: AnyObject {

    func goToStartScreen()
    
}

class SettingsModuleRouter: SettingsModuleRouterProtocol {
    weak var view = StartScreenAssembly.assemble(settings: nil)
    
    func goToStartScreen() {
        if let view = view {
            view.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
