import UIKit

extension BaseViewController {
    struct BaseConstants {
        let yellowColor: UIColor = BombColor.yellow.color
        let orangeColor: UIColor = BombColor.orange.color
        let violetColor: UIColor = BombColor.violet.color
    }
}

class BaseViewController: UIViewController {
    
    private let constants: BaseConstants
    
    private lazy var backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [constants.yellowColor.cgColor, constants.orangeColor.cgColor]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        return layer
    }()
    
    init() {
        self.constants = BaseConstants()
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

extension BaseViewController {
    func createButton(title: String, font: UIFont) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(constants.yellowColor, for: .normal)
        button.backgroundColor = constants.violetColor
        button.titleLabel?.font = font
        return button
    }
    
    func createLabel(text: String, font: UIFont, textColor: UIColor, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        
        label.textAlignment = alignment
        return label
    }
    
    func toStackView(
        subviews: [UIView], spacing: CGFloat,
        axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment) -> UIStackView{
            let stack = UIStackView(arrangedSubviews: subviews)
            stack.spacing = spacing
            stack.axis = axis
            stack.distribution = distribution
            stack.alignment = alignment
            return stack
        }
}
