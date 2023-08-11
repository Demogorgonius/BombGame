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
    }
}

final class GameView: BaseViewController {
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: GameViewOutput
    
    private var pauseBarButtonItem: UIBarButtonItem!
    
    var totalTime = 30// тестовый режим!!!
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
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "animationBobm")
        view.loopMode = .loop
        view.animationSpeed = 1.0
        view.frame = view.bounds
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.stop()
        return view
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
        title = "Игра"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: baseConstants.violetColor]
        let homeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(homeButtonTapped))
        navigationItem.leftBarButtonItem = homeBarButtonItem
    }
    
    // MARK: - Private Methods
    
    @objc private func startButtonTapped() {
        presenter.startButtonTapped()
    }
    @objc private func homeButtonTapped() {
        navigationController?.pushViewController(StartScreenAssembly.assemble(), animated: true)
    }
    private func startTimer() {
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
    
    @objc internal func pauseButtonTapped() {
        if animationView.isAnimationPlaying {
            animationView.pause()
            timer.invalidate()
            titleLabel.text = "ПАУЗА!!!"
            pauseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(pauseButtonTapped))
        } else {
            animationView.play()
            startTimer()
            titleLabel.text = "Назовите вид зимнего спорта"
            pauseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseButtonTapped))
        }
        navigationItem.rightBarButtonItem = pauseBarButtonItem
    }
    
    @objc func updateTimer() {
        
        let animationDuration = TimeInterval(totalTime)

        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = CGFloat(secondsPassed) / CGFloat(totalTime)
            
            // Calculate the frame number based on the percentage progress
            let totalFrames = animationView.animation?.time(forFrame: 1) ?? 0
            let targetFrame = percentageProgress * totalFrames
            
            // Check if the current frame of the animation matches the target frame
            if animationView.currentFrame == targetFrame {
                // Pause the animation
                animationView.pause()
            }
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
        startTimer()
        animationView.play()
        titleLabel.text = "назовите вид зимнего спорта"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseButtonTapped))
        
        navigationController?.navigationBar.tintColor = baseConstants.violetColor
    }
}

private extension GameView {
    func addSubviews() {
        [titleLabel, animationView, startButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(127)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            
            make.leading.trailing.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.bottom.equalToSuperview().inset(constants.buttonStakSidePadding)
            make.height.equalTo(constants.violetButtonHeight)
        }
    }
}

