import UIKit

final class StartScreenView: UIViewController {
    
    private let presenter: StartScreenViewOutput
    
    init(presenter: StartScreenViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension StartScreenView: StartScreenViewInput {
    
}
