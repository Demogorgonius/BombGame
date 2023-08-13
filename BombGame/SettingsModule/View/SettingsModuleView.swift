//
//  SettingsModuleView.swift
//  BombGame
//
//  Created by Sergey on 12.08.2023.
//

import Foundation
import UIKit
import SnapKit

class SettingsModuleView: BaseViewController {
    
    var presenter: SettingsModulePresenterProtocol!
    private let baseConstants = BaseConstants()
    var musicButtonTitle: String = "Мелодия 1"
    var timerButtonTitle: String = "Таймер 1"
    var explosionButtonTitle: String = "Взрыв 1"
    
    lazy var verticalButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15.0
        stack.alignment = .fill
        stack.contentMode = .scaleAspectFit
        stack.distribution = .fillEqually
        [horizontalButtonStack1, horizontalButtonStack2].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    lazy var horizontalButtonStack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 40.0
        stack.alignment = .center
        stack.contentMode = .scaleAspectFill
        stack.distribution = .fillProportionally
        [shortButton, mediumButton].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    lazy var horizontalButtonStack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 40.0
        stack.alignment = .fill
        stack.contentMode = .scaleAspectFill
        stack.distribution = .fillProportionally
        [longButton, randomButton].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    lazy var buttonsTitle: UILabel = {
        let label = UILabel()
        label.text = "Время игры"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var punishmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Игра с заданиями"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var backMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Фоновая музыка"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var backMusicPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Фоновая музыка"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var bombTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Тикание бомбы"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var bombExplosionLabel: UILabel = {
        let label = UILabel()
        label.text = "Взрыв бомбы"
        label.font = UIFont(name: "DelaGothicOne-Regular", size: 20)
        label.textColor = baseConstants.violetColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var punishmentSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.onTintColor = baseConstants.violetColor
        sw.tag = 1
        sw.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
        return sw
    }()
    
    lazy var musicSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.onTintColor = baseConstants.violetColor
        sw.tag = 2
        sw.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
        return sw
    }()
    
    lazy var shortButton: UIButton = {
        let button = createButton(title: "Короткое", font: .regular16)
        button.tag = 1
        button.changesSelectionAsPrimaryAction = true
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.5
        button.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var mediumButton: UIButton = {
        let button = createButton(title: "Середнее", font: .regular16)
        button.tag = 2
        button.changesSelectionAsPrimaryAction = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.5
        button.backgroundColor = BombColor.yellow.color
        button.setTitleColor(BombColor.violet.color, for: .normal)
        button.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var longButton: UIButton = {
        let button = createButton(title: "Длинное", font: .regular16)
        button.tag = 3
        button.changesSelectionAsPrimaryAction = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.5
        button.backgroundColor = BombColor.yellow.color
        button.setTitleColor(BombColor.violet.color, for: .normal)
        button.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var randomButton: UIButton = {
        let button = createButton(title: "Случайное", font: .regular16)
        button.tag = 4
        button.changesSelectionAsPrimaryAction = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 1.5
        button.backgroundColor = BombColor.yellow.color
        button.setTitleColor(BombColor.violet.color, for: .normal)
        button.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var musicButton: UIButton = {
        let button = UIButton(type: .system)
       
        button.setTitle(musicButtonTitle, for: .normal)
        button.titleLabel?.font = .regular16
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(musicButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var timerButton: UIButton = {
        let button = UIButton(type: .system)
       
        button.setTitle(timerButtonTitle, for: .normal)
        button.titleLabel?.font = .regular16
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var explosionButton: UIButton = {
        let button = UIButton(type: .system)
       
        button.setTitle(explosionButtonTitle, for: .normal)
        button.titleLabel?.font = .regular16
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(explosionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DelaGothicOne-Regular", size: 32)!]
        navigationController?.navigationItem.title = "настройки"
        navigationController?.navigationBar.tintColor = baseConstants.violetColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: baseConstants.violetColor]
        if #available(iOS 16.0, *) {
            let homeBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        } else {
            let homeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(homeButtonTapped))
            navigationItem.leftBarButtonItem = homeBarButtonItem
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DelaGothicOne-Regular", size: 32)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        navigationController?.title = "Settings"
        
    }
    
    func setupViews() {
        
        view.addSubview(buttonsTitle)
        view.addSubview(verticalButtonStack)
        view.addSubview(punishmentLabel)
        view.addSubview(punishmentSwitch)
        view.addSubview(backMusicLabel)
        view.addSubview( musicSwitch)
        view.addSubview(backMusicPickerLabel)
        view.addSubview( musicButton)
        view.addSubview(bombTimerLabel)
        view.addSubview(timerButton)
        view.addSubview(bombExplosionLabel)
        view.addSubview(explosionButton)

    }
    
    func setupLayout() {
        
        buttonsTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        shortButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(150)
        }
        
        mediumButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(150)
        }
        
        longButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(150)
        }
        
        randomButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(150)
        }
        
        verticalButtonStack.snp.makeConstraints { make in
            make.top.equalTo(buttonsTitle.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        punishmentLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(verticalButtonStack.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(15)
        }
        
        punishmentSwitch.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(verticalButtonStack.snp.bottom).offset(50)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        backMusicLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(punishmentLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
        }
        
        musicSwitch.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(punishmentLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        backMusicPickerLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(backMusicLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
        }
        
        musicButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(backMusicLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        bombTimerLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(backMusicPickerLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
        }
        
        timerButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(backMusicPickerLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        bombExplosionLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(bombTimerLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
        }
        
        explosionButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(bombTimerLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        
        
        
    }
    
   
    
}

extension SettingsModuleView {
    
    @objc func homeButtonTapped() {
              presenter.backButtonTapped()
    }
    
    @objc func switchToggle(_ sender: UISwitch) {
        
    }
    
    func toggleButton(_ sender: UIButton) {
        
        if sender.backgroundColor == BombColor.yellow.color {
            sender.backgroundColor = BombColor.violet.color
            sender.setTitleColor(BombColor.yellow.color, for: .normal)
        } else  {
            sender.backgroundColor = BombColor.yellow.color
            sender.setTitleColor(BombColor.violet.color, for: .normal)
        }
    
    }
    
    func offButton(_ sender: UIButton) {
        
            sender.changesSelectionAsPrimaryAction = false
            sender.backgroundColor = BombColor.yellow.color
            sender.setTitleColor(BombColor.violet.color, for: .normal)
     
    }
    
    @objc func durationButtonTapped(_ sender: UIButton) {
       
        toggleButton(sender)
        
       switch sender.tag {
        case 1:
           if sender.backgroundColor == BombColor.violet.color {
               mediumButton.backgroundColor = BombColor.yellow.color
               mediumButton.setTitleColor(BombColor.violet.color, for: .normal)
               longButton.backgroundColor = BombColor.yellow.color
               longButton.setTitleColor(BombColor.violet.color, for: .normal)
               randomButton.backgroundColor = BombColor.yellow.color
               randomButton.setTitleColor(BombColor.violet.color, for: .normal)
           }
        case 2:
           if sender.backgroundColor == BombColor.violet.color {
               shortButton.backgroundColor = BombColor.yellow.color
               shortButton.setTitleColor(BombColor.violet.color, for: .normal)
               longButton.backgroundColor = BombColor.yellow.color
               longButton.setTitleColor(BombColor.violet.color, for: .normal)
               randomButton.backgroundColor = BombColor.yellow.color
               randomButton.setTitleColor(BombColor.violet.color, for: .normal)
           }

        case 3:
           
           if sender.backgroundColor == BombColor.violet.color {
               shortButton.backgroundColor = BombColor.yellow.color
               shortButton.setTitleColor(BombColor.violet.color, for: .normal)
               mediumButton.backgroundColor = BombColor.yellow.color
               mediumButton.setTitleColor(BombColor.violet.color, for: .normal)
               randomButton.backgroundColor = BombColor.yellow.color
               randomButton.setTitleColor(BombColor.violet.color, for: .normal)
           }
           
        case 4:
           
           if sender.backgroundColor == BombColor.violet.color {
               shortButton.backgroundColor = BombColor.yellow.color
               shortButton.setTitleColor(BombColor.violet.color, for: .normal)
               mediumButton.backgroundColor = BombColor.yellow.color
               mediumButton.setTitleColor(BombColor.violet.color, for: .normal)
               longButton.backgroundColor = BombColor.yellow.color
               longButton.setTitleColor(BombColor.violet.color, for: .normal)
           }
           
        default:
            return
        }
    }
    
    @objc func musicButtonTapped(_ sender: UIButton) {
        
    }
    @objc func timerButtonTapped(_ sender: UIButton) {
        
    }
    @objc func explosionButtonTapped(_ sender: UIButton) {
        
    }
    
}

extension SettingsModuleView: SettingsModuleViewProtocol {
    
    
    
}
