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
    func punishmentOn(state: Bool)
    func gameDuration(duration: Int)
    func getSettings()
    var settings: GameSettings? {get set}
}

class SettingsModulePresenter: SettingsModulePresenterProtocol {
    
    
    weak var view: SettingsModuleViewProtocol?
    var router: SettingsModuleRouterProtocol!
    var settingsManager: SettingsManagerProtocol?
    var settings: GameSettings?
    
    
    required init(view: SettingsModuleViewProtocol, router: SettingsModuleRouterProtocol, settingsManager: SettingsManagerProtocol) {
        self.view = view
        self.router = router
        self.settingsManager = settingsManager
    }
    
    func getSettings() {
        settingsManager?.getSettings(completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func gameDuration(duration: Int) {
        settingsManager?.getSettings(completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        settings?.gameDuration = duration
        settingsManager?.saveSettings(gameDuration: duration, gameMelody: nil, gameBombExplosion: nil, gameTimerSound: nil, isPunishment: nil, completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func punishmentOn(state: Bool) {
        settingsManager?.getSettings(completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        settings?.isPunishment = state
        settingsManager?.saveSettings(gameDuration: nil, gameMelody: nil, gameBombExplosion: nil, gameTimerSound: nil, isPunishment: state, completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func backButtonTapped() {
        router.goToStartScreen()
    }
    
}

