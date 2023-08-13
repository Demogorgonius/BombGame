import Foundation

final class GameEndPresenter {
    
    weak var view: GameEndViewInput?
    var  previousPunishment = ""
    var currentPunishment = ""
    var settings: GameSettings?
    
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
    
    func getSettings() {
        settingsManager.getSettings(completion: { result in
            switch result {
            case .success(let settings):
                self.settings = settings
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
