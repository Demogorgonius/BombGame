import UIKit

final class GameEndScreenViewRouter: GameEndScreenRouterInput {
    
    weak var view: UIViewController?
    
    func routeToGameScreen() {
        let view = GameAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToStartScreen() {
        if let view = view {
            view.navigationController?.popToRootViewController(animated: true)
        }
    }
}
