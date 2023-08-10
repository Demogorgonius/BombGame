import Foundation

final class CategoryPresenter {
    
    weak var view: CategoryViewInput?
    private let router: CategoryRouterInput
    
    init(router: CategoryRouterInput) {
        self.router = router
    }
    
}

extension CategoryPresenter: CategoryViewOutput {
    func viewDidLoad() {
        DispatchQueue.main.async {
            self.view?.update(with: [.init(title: "HELLO", imageName: "bomb", isSelected: false, didSelect: {
                print("select")
            })])
        }
    }
}
