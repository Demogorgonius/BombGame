//
//  SettingsManager.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation

enum GameDuration: Int {
    case short = 10
    case medium = 20
    case long = 45
    case random = 30
}

enum GameMelody: String {
    case melody1 = "fonovaya-muzyika-quotproyasneniequot-24769"
    case melody2 = "kitayskiy-novyiy-reper-korotkaya-muzyika-perehodnaya-muzyika-ritm-muzyika-38526"
    case melody3 = "muzyika-iz-igryi-zelda-23480"
    case noMelody = ""
}

enum BombExplosion: String {
    case explSound1 = "vzryiv-bombyi-s-vyiryivayuschimsya-plamenem-32161"
    case explSound2 = "vzryiv-bombyi-syipyatsya-oskolki-32133"
    case explSound3 = "moschnyiy-vzryiv-bombyi-s-oskolkami-i-steklom-32159"
}

enum TimerSound: String {
    case timerSound1 = "gorit-fitil-38103"
    case timerSound2 = "taymer-na-staryih-chasah"
    case timerSound3 = "derevyannyiy-stuk-taymera"
}

struct GameSettings: Codable {
    var gameDuration: Int = GameDuration.short.rawValue
    var gameMelody: String = GameMelody.melody1.rawValue
    var gameBombExplosion: String = BombExplosion.explSound1.rawValue
    var gameTimerSound: String = TimerSound.timerSound1.rawValue
    var isPunishment: Bool = true
}

protocol SettingsManagerProtocol {
    
    func saveSettings(gameDuration: Int?,
                      gameMelody: GameMelody?,
                      gameBombExplosion: BombExplosion?,
                      gameTimerSound: TimerSound?,
                      isPunishment: Bool?,
                      completion: @escaping(Result<GameSettings, Error>)->Void)
    func getSettings(completion: @escaping(Result<GameSettings,Error>)->Void)
    func savingGame() -> Bool
    
}

class SettingsManager: SettingsManagerProtocol {
    
    let defaults = UserDefaults.standard
    
    func saveSettings(gameDuration: Int?,
                      gameMelody: GameMelody?,
                      gameBombExplosion: BombExplosion?,
                      gameTimerSound: TimerSound?,
                      isPunishment: Bool?,
                      completion: @escaping (Result<GameSettings, Error>) -> Void) {
        
        
        let settings = GameSettings(gameDuration: gameDuration ?? GameDuration.short.rawValue,
                                    gameMelody: gameMelody?.rawValue ?? GameMelody.melody1.rawValue,
                                    gameBombExplosion: gameBombExplosion?.rawValue ?? BombExplosion.explSound1.rawValue,
                                    gameTimerSound: gameTimerSound?.rawValue ?? TimerSound.timerSound1.rawValue,
                                    isPunishment: isPunishment ?? true)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(settings) {
            
            defaults.set(encoded, forKey: "gameSettings")
        }
        
        if let settings = defaults.object(forKey: "gameSettings") as? Data {
            let decoder = JSONDecoder()
                if let loadedSettings = try? decoder.decode(GameSettings.self, from: settings) {
                    completion(.success(loadedSettings))
                }
            
        } else {
            completion(.failure(QuestionsErrors.saveSettingsError))
        }
    }
    
    func getSettings(completion: @escaping (Result<GameSettings, Error>) -> Void) {
        if let settings = defaults.object(forKey: "gameSettings") as? Data {
            let decoder = JSONDecoder()
                if let loadedSettings = try? decoder.decode(GameSettings.self, from: settings) {
                    completion(.success(loadedSettings))
                }
            
        } else {
            completion(.failure(QuestionsErrors.saveSettingsError))
        }
    }
    
    func savingGame() -> Bool {
        
        if ((defaults.object(forKey: "savedQuestions") as? [String]) != nil) {
            return true
        } else {
            return false
        }
    }
    
}
