import UIKit
import SnapKit

extension GameEndScreenView {
    struct Constants {
        let violetButtonHeight: CGFloat = 79.0
        let buttonStakSidePadding: CGFloat = 45.0
        let titleLabelSidePadding: CGFloat = 3.0
        let titleLabelTopPadding: CGFloat = 120.0
        let imageProportion: CGFloat = 249.0 / 300.0
        
        let bombImage: UIImage? = UIImage(named: "explosion")
    }
}

class GameEndScreenView: BaseViewController {
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: GameEndViewOutput
    
    private lazy var punishmentButton: UIButton = {
        let button = createButton(title: "Другое наказание", font: .regular24)
        button.addTarget(nil, action: #selector(punishmentButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        return button
    }()
    
    private lazy var restartButton: UIButton = {
        let button = createButton(title: "Начать заново", font: .regular24)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        button.addTarget(nil, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        return createLabel(
            text: "Проигравший выполняет задание", font: .regular24,
            textColor: .black, alignment: .center
        )
    }()
    
    private lazy var bombImageView: UIImageView = {
        let view = UIImageView(image: constants.bombImage)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var punishmentLabel: UILabel = {
        return createLabel(
            text: "В следующем раунде после каждого ответа хлопать в ладоши",
            font: .regular24, textColor: baseConstants.violetColor,
            alignment: .center
        )
    }()
    
    private lazy var buttonsStack: UIStackView = {
        return toStackView(
            subviews: [punishmentButton, restartButton],
            spacing: 10, axis: .vertical, distribution: .fillEqually,
            alignment: .fill
        )
    }()
    
    init(presenter: GameEndViewOutput) {
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
        title = "Игра"
    }
    
    @objc func restartButtonTapped() {
        presenter.restartButtonTapped()
    }
    
    @objc func punishmentButtonTapped () {
        presenter.punishmentButtonTapped()
    }
}

extension GameEndScreenView: GameEndViewInput {
    func updatePunishment() {
        punishmentLabel.text = "улыбнись"
    }
    
    
}

private extension GameEndScreenView {
    func addSubviews() {
        [titleLabel, bombImageView, punishmentLabel, buttonsStack].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.top.equalToSuperview().inset(constants.titleLabelTopPadding)
        }
        
        bombImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(166)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-346)
            make.width.equalTo(bombImageView.snp.height).multipliedBy(constants.imageProportion)

        }
        
        punishmentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.top.equalTo(bombImageView.snp.bottom)
        }
        
        [punishmentButton, restartButton].forEach({
            $0.snp.makeConstraints { make in
                make.height.equalTo(constants.violetButtonHeight)
            }
        })
        
        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(punishmentLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview().inset(constants.buttonStakSidePadding)
        }
    }
}
