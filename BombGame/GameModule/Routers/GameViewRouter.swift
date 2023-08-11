import UIKit

final class GameViewRouter: GameRouterInput {
    weak var view: UIViewController?
    
    func routeToStartScreen() {
        let view = StartScreenAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
