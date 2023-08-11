//
//  GamePresenter.swift
//  BombGame
//
//  Created by Келлер Дмитрий on 08.08.2023.
//

import Foundation

final class GamePresenter {
    
    weak var view: GameViewInput?
    
    private let router: GameRouterInput
    
    init(router: GameRouterInput) {
        self.router = router
    }
}

extension GamePresenter: GameViewOutput {
    func startTimer() {
        view?.addTimer()
    }
    
    func pauseButtonTapped() {
        view?.updateTimerAnimation()
    }
    
    func startButtonTapped() {
        view?.updateGameUI()
    }
    
    func homeButtonTapped() {
        self.router.routeToStartScreen()
    }
}
