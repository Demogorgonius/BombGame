import UIKit
import SnapKit

extension StartScreenView {
    struct Constants {
        let violetButtonHeight: CGFloat = 79.0
        let buttonStakSidePadding: CGFloat = 45.0
        let titleLabelSidePadding: CGFloat = 2.0
        let titleLabelTopPadding: CGFloat = 57.0
        let imageProportion: CGFloat = 375.0 / 409.0
        let bombImage: UIImage? = UIImage(named: "bomb")
    }
}

class StartScreenView: BaseViewController {
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: StartScreenViewOutput
    
    private lazy var startButton: UIButton = {
        let button = createButton(title: "Запустить", font: .regular24)
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        return button
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = createButton(title: "Категории", font: .regular24)
        button.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        return createLabel(
            text: "Игра для компании", font: .bold32,
            textColor: .black, alignment: .center
        )
    }()
    
    private lazy var gameLabel: UILabel = {
        return createLabel(
            text: "БОМБА", font: .bold48, textColor: baseConstants.violetColor,
            alignment: .center
        )
    }()
    
    private lazy var bombImageView: UIImageView = {
        let view = UIImageView(image: constants.bombImage)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
        return toStackView(
            subviews: [startButton, categoryButton],
            spacing: 10, axis: .vertical, distribution: .fillEqually,
            alignment: .fill
        )
    }()
    
    lazy var rulesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rulesButton"), for: .normal)
        button.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(presenter: StartScreenViewOutput) {
        self.presenter = presenter
        self.baseConstants = BaseConstants()
        self.constants = Constants()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeLayout()
    }
}

extension StartScreenView: StartScreenViewInput {
    
}

private extension StartScreenView {
    
    @objc func didTapCategory() {
        presenter.didTapCategory()
    }
    
    @objc func didTapPlay() {
        presenter.didTapPlay()
    }
    
    @objc func rulesButtonTapped() {
        presenter.rulesButtonTapped()
    }
    
    
    
    func addSubviews() {
        [titleLabel, gameLabel, bombImageView, buttonsStack, rulesButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.top.equalToSuperview().inset(constants.titleLabelTopPadding)
        }
        
        gameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        bombImageView.snp.makeConstraints { make in
            
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(123)
            make.bottom.equalToSuperview().offset(-280)
            make.width.equalTo(bombImageView.snp.height).multipliedBy(constants.imageProportion)
        }
        
        [startButton, categoryButton].forEach({
            $0.snp.makeConstraints { make in
                make.height.equalTo(constants.violetButtonHeight)
            }
        })
        
        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(bombImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview().offset(-94)
        }
        
        rulesButton.snp.makeConstraints { make in
            make.top.equalTo (categoryButton.snp.bottom).offset(0)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(62)
            make.width.equalTo(62)
        }
    }
}
