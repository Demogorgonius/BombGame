import UIKit

extension BaseViewController {
    struct Constants {
        let startBackColor: UIColor = BombColor.yellow.color
        let endColor: UIColor = BombColor.orange.color
    }
}

class BaseViewController: UIViewController {
    
    private let constants: Constants
    
    private lazy var backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [constants.startBackColor.cgColor, constants.endColor.cgColor]
        //layer.locations = [0.0, 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        return layer
    }()
    
    init() {
        self.constants = Constants()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.backgroundLayer.removeFromSuperlayer()
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        self.backgroundLayer.frame = self.view.bounds
    }
}
