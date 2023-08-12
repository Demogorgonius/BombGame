import UIKit

final class CategoryRouter: CategoryRouterInput {
    weak var view = StartScreenAssembly.assemble(settings: nil)
    
    func routeToStartScreen() {
        if let view = view {
            view.navigationController?.popToRootViewController(animated: true)
        }
    }

}
