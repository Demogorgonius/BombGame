import UIKit

final class StartScreenViewRouter: StartScreenRouterInput {
    
    weak var view: UIViewController?
    
    func routeToCategory() {
        let view = CategoryAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
