import Foundation

final class GameEndPresenter {
    
    weak var view: GameEndViewInput?
    var  previousPunishment = ""
    var currentPunishment = ""
    
    private let router: GameEndScreenRouterInput
    private let settingsManager: SettingsManagerProtocol
    private let questionsManager: QuestionsManagerProtocol
    
    init(router: GameEndScreenRouterInput,
         settingsManager: SettingsManagerProtocol,
         questionsManager: QuestionsManagerProtocol
    )
    {
        self.router = router
        self.settingsManager = settingsManager
        self.questionsManager = questionsManager
    }
    
}

extension GameEndPresenter: GameEndViewOutput {
    func getPunishment() -> String {
        var currentPunishment = questionsManager.getRandomPunishment()
        
        while currentPunishment == previousPunishment {
            currentPunishment = questionsManager.getRandomPunishment()
        }
        
        previousPunishment = currentPunishment
        
        return currentPunishment
    }
    
    
    func punishmentButtonTapped() {
        view?.updatePunishment()
    }
    
    func restartButtonTapped() {
        self.router.routeToGameScreen()
    }
    
    func homeButtonTapped() {
        self.router.routeToStartScreen()
    }
    
}
