//
//  SettingsModulePresenter.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation

protocol SettingsModuleViewProtocol: AnyObject {
    
}

protocol SettingsModulePresenterProtocol: SettingsModuleViewProtocol {
    
    init(view: SettingsModuleViewProtocol, router: SettingsModuleRouterProtocol, settingsManager: SettingsManagerProtocol)
    func backButtonTapped()
}

class SettingsModulePresenter: SettingsModulePresenterProtocol {
    
    weak var view: SettingsModuleViewProtocol?
    var router: SettingsModuleRouterProtocol!
    var settingsManager: SettingsManagerProtocol?
    
    required init(view: SettingsModuleViewProtocol, router: SettingsModuleRouterProtocol, settingsManager: SettingsManagerProtocol) {
        self.view = view
        self.router = router
        self.settingsManager = settingsManager
    }
    
    
    func backButtonTapped() {
        router.goToStartScreen()
    }
    
}

