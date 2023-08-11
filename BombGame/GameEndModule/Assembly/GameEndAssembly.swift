import UIKit

final class GameEndAssembly {
    static func assemble() -> UIViewController {
        let router = GameEndScreenViewRouter()
        let presenter = GameEndPresenter(router: router)
        let view = GameEndScreenView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
