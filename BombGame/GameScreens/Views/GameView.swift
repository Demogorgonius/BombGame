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
    
    private var animationView: LottieAnimationView?
    
    var totalTime = 5 // тестовый режим!!!
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
        // 2. Start LottieAnimationView
        animationView = .init(name: "animationBobm")
        animationView!.frame = view.bounds
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.3
        view.addSubview(animationView!)
        // 6. Play animation
        animationView!.stop()
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
        
        animationView?.play()
    }
    
}

private extension GameView {
    func addSubviews() {
        [titleLabel, startButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(constants.titleLabelSidePadding)
            make.top.equalToSuperview().inset(constants.buttonStakSidePadding)
        }
        
        startButton.snp.makeConstraints { make in
            
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview().inset(constants.buttonStakSidePadding)
        }
    }
}

