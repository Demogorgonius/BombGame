import Foundation

final class GameEndPresenter {
    
    weak var view: GameEndViewInput?
    
    private let router: GameEndScreenRouterInput
    
    init(router: GameEndScreenRouterInput) {
        self.router = router
    }
    
}

extension GameEndPresenter: GameEndViewOutput {
    
}
