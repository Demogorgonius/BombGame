//
//  GameViewOutput.swift
//  BombGame
//
//  Created by Келлер Дмитрий on 08.08.2023.
//

import Foundation

protocol GameViewOutput {
    
    func startButtonTapped()
    func pauseButtonTapped()
    func homeButtonTapped()
    func startTimer()
    func getQuestion() -> String
    func getQuestionsArray()
    var currentQuestion: String {get}
    var settings: GameSettings? {get}
    func getSettings()
}
