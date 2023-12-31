//
//  GameView.swift
//  BombGame
//
//  Created by Келлер Дмитрий on 08.08.2023.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation

extension GameView {
    struct Constants {
        let violetButtonHeight: CGFloat = 79.0
        let buttonStakSidePadding: CGFloat = 45.0
        let titleLabelSidePadding: CGFloat = 8.0
        let titleLabelTopPadding: CGFloat = 57.0
    }
}

final class GameView: BaseViewController {
    
    enum MusicPath: String {
        case fire = "gorit-fitil-38103"
        case bomb = "vzryiv-bombyi-syipyatsya-oskolki-32133"
        
        var url: URL? {
            let path = Bundle.main.path(forResource: self.rawValue, ofType: "mp3")
            guard let path else { return nil }
            return URL(fileURLWithPath: path)
        }
    }
    
    init(presenter: GameViewOutput) {
        self.presenter = presenter
        self.baseConstants = BaseConstants()
        self.constants = Constants()
        super.init()
    }
    
    private let constants: Constants
    private let baseConstants: BaseConstants
    private let presenter: GameViewOutput
    
    private var startTime: TimeInterval?
    private var elapsedTime: TimeInterval?
    

    
    private var pauseBarButtonItem: UIBarButtonItem!
    
    var totalTime: TimeInterval =  15.0
    var secondsPassed = 0.0
    var timer = Timer()
    let totalDuration = 8.3
    private var audioPlayer: AVAudioPlayer?
    var animationSpeed: Double {
        return totalDuration / totalTime
    }
    

    private lazy var mainTitle: UILabel = {
        return createLabel(
            text: "Игра",
            font: .bold32,
            textColor: baseConstants.violetColor,
            alignment: .center
        )
    }()
    
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
        view.frame = view.bounds
        view.contentMode = .scaleAspectFill
        view.animationSpeed = getAnimationSpeed()
//        view.animationSpeed = animationSpeed
        print(animationSpeed)
        view.stop()
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = createButton(title: "Запустить", font: .regular24)
        button.layer.cornerRadius = constants.violetButtonHeight / 2
        button.addTarget(nil, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeLayout()


        if #available(iOS 16.0, *) {
            let homeBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        } else {
            let homeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        }
        presenter.getSettings()
        presenter.getQuestionsArray()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Methods
    
    @objc private func startButtonTapped() {
        presenter.startButtonTapped()
    }
    
    @objc private func pauseButtonTapped() {
        presenter.pauseButtonTapped()
    }
    
    private func startTimer() {
        presenter.startTimer()
    }
    
    @objc private func homeButtonTapped() {
        presenter.homeButtonTapped()
    }
}

// MARK: - GameViewInput
extension GameView: GameViewInput {
    
    func addTimer() {
        timer.invalidate()
        startTime = Date.timeIntervalSinceReferenceDate
        secondsPassed = 0
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func getAnimationSpeed() -> CGFloat {
        
        presenter.getSettings()
        
        let duration = presenter.settings?.gameDuration
        
        return totalDuration / Double(duration!)
        
    }
    
    func getTotalTime() -> CGFloat {
        presenter.getSettings()
        
        let duration = presenter.settings?.gameDuration
        return Double(duration!)
    }
    
    @objc func updateTimer() {
        
        if secondsPassed == getTotalTime() - 3 {
            playSound(path: .bomb)
        }
        
        if secondsPassed < getTotalTime() {
            secondsPassed += 1
        } else {
            print(secondsPassed)
            timer.invalidate()
            animationView.stop()
            animationView.isHidden = true
            audioPlayer?.numberOfLoops = 0
            let endGameScreen = GameEndAssembly.assemble()
            navigationController?.pushViewController(endGameScreen, animated: true)
        }
    }
    
    func updateGameUI() {
        startButton.isHidden = true
        startTimer()
        playSound(path: .fire)
        animationView.play()
        animationView.animationSpeed = getAnimationSpeed()
        titleLabel.text = presenter.getQuestion()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseButtonTapped))
        
        navigationController?.navigationBar.tintColor = baseConstants.violetColor
    }
    
    func updateTimerAnimation() {
        if animationView.isAnimationPlaying {
            animationView.pause()
            audioPlayer?.pause()
            elapsedTime = Double(Int(Date.timeIntervalSinceReferenceDate - (startTime ?? 0.0)))
            timer.invalidate()
            titleLabel.text = "ПАУЗА!!!"
            pauseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(pauseButtonTapped))
        } else {
            animationView.play()
            audioPlayer?.play()
            totalTime = Double(presenter.settings?.gameDuration ?? 15)
            totalTime -= elapsedTime ?? 0.0
            startTimer()
            titleLabel.text = presenter.currentQuestion
            pauseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseButtonTapped))
        }
        navigationItem.rightBarButtonItem = pauseBarButtonItem
    }
    
}

private extension GameView {
    func playSound(path: MusicPath) {
        guard let url = path.url else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = 5
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addSubviews() {
        [mainTitle, titleLabel, animationView, startButton].forEach({ self.view.addSubview($0) })
    }
    
    func makeLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
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


