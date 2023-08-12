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
    func dadTapPlay() {
        print(settings)
        self.router.routeToGame()
    }
    
    func didTapCategory() {
        self.router.routeToCategory()
    }
}
