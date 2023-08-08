import UIKit
import SnapKit

extension GameEndScreenView {
    struct Constants {
        let violetButtonHeight: CGFloat = 79.0
        let buttonStakSidePadding: CGFloat = 45.0
        let titleLabelSidePadding: CGFloat = 8.0
        let titleLabelTopPadding: CGFloat = 57.0
        
        let bombImage: UIImage? = UIImage(named: "explosion")
    }
}

class GameEndScreenView: BaseViewController {
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: GameEndViewOutput
    
    private lazy var startButton: UIButton = {
        let button = createButton(title: "Другое задание", font: .regular24)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        return button
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = createButton(title: "Начать заново", font: .regular24)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        return createLabel(
            text: "Проигравший выполняет задание", font: .regular24,
            textColor: .black, alignment: .center
        )
    }()
    
    private lazy var punishmentLabel: UILabel = {
        return createLabel(
            text: "В следующем раунде после каждого ответа хлопать в ладоши",
            font: .regular24, textColor: baseConstants.violetColor,
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
    }
}

extension GameEndScreenView: GameEndViewInput {
    
}

private extension GameEndScreenView {
    func addSubviews() {
        [titleLabel, punishmentLabel, bombImageView, buttonsStack].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.top.equalToSuperview().inset(constants.titleLabelTopPadding)
        }
        
        punishmentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        bombImageView.snp.makeConstraints { make in
            make.top.equalTo(punishmentLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.snp.height).dividedBy(1.8)
        }
        
        [startButton, categoryButton].forEach({
            $0.snp.makeConstraints { make in
                make.height.equalTo(constants.violetButtonHeight)
            }
        })
        
        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(bombImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview()
        }
    }
}
