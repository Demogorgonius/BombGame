import Foundation

final class StartScreenPresenter {
    
    weak var view: StartScreenViewInput?
    
    private let router: StartScreenRouterInput
    
    init(router: StartScreenRouterInput) {
        self.router = router
    }
    
}

extension StartScreenPresenter: StartScreenViewOutput {
    
}
