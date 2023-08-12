import UIKit

final class StartScreenViewRouter: StartScreenRouterInput {
    
    
    
    weak var view: UIViewController?
    
    func routeToSettings() {
        let view = CategoryAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToCategory() {
        let view = CategoryAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToGame() {
        let view = GameAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToRules() {
        let view = RulesViewController()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
