//
//  SettingsModuleBulder.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation
import UIKit

protocol SettingsModuleBuilderProtocol: AnyObject {
    
    func createSettingsModule() -> UIViewController
    
}

class SettingsModuleBuilder: SettingsModuleBuilderProtocol {
    
    func createSettingsModule() -> UIViewController {
        
        let settingsManager = SettingsManager()
        let router = SettingsModuleRouter()
        let view = SettingsModuleView()
        let presenter = SettingsModulePresenter(view: view, router: router, settingsManager: settingsManager)
        view.presenter = presenter
        router.view = view
        return view
        
    }
    
}
