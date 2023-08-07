import UIKit

class StartScreenView: BaseViewController {
    
    private let presenter: StartScreenViewOutput
    
    init(presenter: StartScreenViewOutput) {
        self.presenter = presenter
        super.init()
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
