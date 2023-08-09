//
//  GameView.swift
//  BombGame
//
//  Created by Келлер Дмитрий on 08.08.2023.
//

import UIKit
import SnapKit
import Lottie

extension GameView {
    struct Constants {
        let violetButtonHeight: CGFloat = 79.0
        let buttonStakSidePadding: CGFloat = 45.0
        let titleLabelSidePadding: CGFloat = 8.0
        let titleLabelTopPadding: CGFloat = 57.0
        
        let bombImage: UIImage? = UIImage(named: "bomb")
    }
}

final class GameView: BaseViewController {
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: GameViewOutput
    
    private var animationView: LottieAnimationView
    
    var totalTime = 35// тестовый режим!!!
    var secondsPassed = 0
    var timer = Timer()
    
    private lazy var titleLabel: UILabel = {
        return createLabel(
            text: "Нажмите\n" + "\"Запустить\"\n" + "чтобы начать игру",
            font: .regular24,
            textColor: baseConstants.violetColor,
            alignment: .center
        )
    }()

    private lazy var startButton: UIButton = {
        let button = createButton(title: "Запустить", font: .regular24)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        button.addTarget(nil, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(presenter: GameViewOutput) {
        self.presenter = presenter
        self.baseConstants = BaseConstants()
        self.constants = Constants()
        self.animationView = LottieAnimationView()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeLayout()
        bombLottiAnimation()
        startTimer()
    }
    
    // MARK:- Private Methods
    @objc private func startButtonTapped() {
        presenter.startButtonTapped()
    }
    
    private func bombLottiAnimation() {
        animationView = .init(name: "animationBobm")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.3
        
        view.addSubview(animationView)

        animationView.stop()

        animationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(223)
            make.leading.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview().offset(-237)
        }
    }
    
    func startTimer () {
         timer.invalidate()
         
         secondsPassed = 0
         timer = Timer.scheduledTimer(
             timeInterval: 1.0,
             target: self,
             selector: #selector(updateTimer),
             userInfo: nil,
             repeats: true
         )
     }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            
        } else {
            timer.invalidate()
            let endGameScreen = GameEndAssembly.assemble()
            navigationController?.pushViewController(endGameScreen, animated: true)
        }
    }
}

extension GameView: GameViewInput {
    func updateGameUI() {
        startButton.isHidden = true

        titleLabel.text = "назовите вид зимнего спорта"
        
        animationView.play()
    }
    
}

private extension GameView {
    func addSubviews() {
        [titleLabel, startButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(127)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        
        startButton.snp.makeConstraints { make in
            
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.height.equalTo(constants.violetButtonHeight)
        }
    }
}

