import UIKit

final class StartScreenViewRouter: StartScreenRouterInput {
    
    
    weak var view: UIViewController?
    
    func routeToCategory() {
        let view = CategoryAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToGame() {
        let view = GameAssembly.assemble()
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    func routeToContinueGame() {
        let settingsRouter = SettingsModuleRouter()
        let builder = SettingsModuleBuilder()
        let view = builder.createSettingsModule(router: settingsRouter)
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
