import UIKit

final class StartScreenAssembly {
    static func assemble(settings: GameSettings?) -> UIViewController {
        let router = StartScreenViewRouter()
        let presenter = StartScreenPresenter(router: router, settings: settings)
        let view = StartScreenView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
