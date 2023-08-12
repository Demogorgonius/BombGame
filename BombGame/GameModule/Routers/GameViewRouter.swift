import UIKit

final class GameViewRouter: GameRouterInput {
    weak var view: UIViewController?
    
    func routeToStartScreen() {
        view = StartScreenAssembly.assemble(settings: nil)
        self.view?.navigationController?.popToRootViewController(animated: true)
    }
}
