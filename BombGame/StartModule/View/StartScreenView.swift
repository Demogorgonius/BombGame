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
    let defaults = UserDefaults.standard
    
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
    
    private lazy var continueButton: UIButton = {
        let button = createButton(title: "Продолжить", font: .regular24)
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
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
            subviews: [startButton, continueButton, categoryButton],
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
    
    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
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
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.object(forKey: "loadGame") == nil {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
        }
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension StartScreenView: StartScreenViewInput {
    
}
// MARK: - Add Buttons Methods
private extension StartScreenView {
    
    @objc func didTapCategory() {
        presenter.didTapCategory()
    }
    
    @objc func didTapPlay() {
        presenter.didTapPlay()
    }
    
    @objc func didTapContinueButton() {
        presenter.didTapContinueButton()
    }

    @objc func rulesButtonTapped() {
        presenter.rulesButtonTapped()
    }
    
    @objc func settingsButtonTapped() {
        presenter.settingsButtonTapped()
    }

    func addSubviews() {
        [titleLabel, gameLabel, bombImageView, buttonsStack, rulesButton, settingsButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.height.equalTo(44.8)
                }

                gameLabel.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(titleLabel.snp.bottom)
                    make.height.equalTo(44.8)
                }

                bombImageView.snp.makeConstraints { make in
                    make.top.equalTo(gameLabel.snp.bottom)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(340)
                    make.width.equalTo(350)
                    //make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
                    make.bottom.equalTo(buttonsStack.snp.top)
                }
        
        [startButton, continueButton, categoryButton].forEach({
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
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo (categoryButton.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(62)
            make.width.equalTo(62)
        }
    }
}
