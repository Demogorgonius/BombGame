import UIKit

final class StartScreenAssembly {
    static func assemble() -> UIViewController {
        let router = StartScreenViewRouter()
        let presenter = StartScreenPresenter(router: router)
        let view = StartScreenView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
