import Foundation

final class StartScreenPresenter {
    
    weak var view: StartScreenViewInput?
    private var settings: GameSettings?
    private let router: StartScreenRouterInput
    
    init(router: StartScreenRouterInput, settings: GameSettings?) {
        self.settings = settings
        self.router = router
    }
    
}

extension StartScreenPresenter: StartScreenViewOutput {
    func didTapContinueButton() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "loadGame")
        self.router.routeToGame()
    }
    
    func settingsButtonTapped() {
        self.router.routeToSettings()
    }
    
    func didTapPlay() {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "loadGame")
        self.router.routeToGame()
    }
    
    func didTapCategory() {
        self.router.routeToCategory()
    }
    
    func rulesButtonTapped() {
        self.router.routeToRules()
    }
    
}

