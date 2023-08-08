import UIKit

final class GameAssembly {
    static func assemble() -> UIViewController {
        let router = GameViewRouter()
        let presenter = GamePresenter(router: router)
        let view = GameView(presenter: presenter)
        
        presenter.view = view as? any GameViewInput
        router.view = view
        
        return view
    }
}
