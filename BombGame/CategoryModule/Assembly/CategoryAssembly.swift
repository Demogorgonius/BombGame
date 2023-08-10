import UIKit

final class CategoryAssembly {
    static func assemble() -> UIViewController {
        let router = CategoryRouter()
        let presenter = CategoryPresenter(router: router)
        let view = CategoryView(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
