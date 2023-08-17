//
//  RulesViewController.swift
//  BombGame
//
//  Created by Кирилл Корнев on 08.08.2023.
//

import UIKit
import SnapKit

class RulesViewController: BaseViewController {
    
    // MARK: - Views
    private lazy var backButton = UIButton(type: .system)
    private lazy var mainTitle = UILabel()
    private lazy var secondMainTitle = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var firstNumber = UILabel()
    
    // MARK: - Stacks
    private lazy var startGameImage = UIImageView()
    private lazy var firstStack = createStack(
        text: "Все игроки становятся в круг.",
        number: 1
    )
    private lazy var secondStack = createStack(
        text: "Первый игрок берет телефон и нажимает кнопку:",
        number: 2
    )
    private lazy var thirdtack = createStack(
        text: "На экране появляется вопрос “Назовите Фрукт”.",
        number: 3
    )
    private lazy var fourthStack = createStack(
        text: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники).",
        number: 4
    )
    private lazy var fiveStack = createStack(
        text: "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.",
        number: 5
    )
    private lazy var sixthStack = createStack(
        text: "Проигравшим считается тот, в чьих руках взорвалась бомба.",
        number: 6
    )
    private lazy var seventhStack = createStack(
        text: "Если в настройках выбран режим игры “С Заданиями”, то проигравший выполняет задание.",
        number: 7
    )
    
    private lazy var mainStack = UIStackView()
    
    // MARK: - CategoryStack
    private lazy var thirdMainTitle = UILabel()
    private lazy var categoryStack = UIStackView()
    private lazy var firstCategoryLabel = UILabel()
    private lazy var secondCategoryLabel = UILabel()
    private lazy var firstCategoryStack = UIStackView()
    private lazy var secondCategoryStack = UIStackView()
    private lazy var natureCatImage = UIImageView()
    private lazy var cinemaCatImage = UIImageView()
    private lazy var otherCatImage = UIImageView()
    private lazy var sportCatImage = UIImageView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupConstraints()
        navigationController?.navigationBar.isHidden = true
        
    }
}

// MARK: - Private Methods

private extension RulesViewController {
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
// MARK: - Methods for UI
private extension RulesViewController {
    
    func setup() {
        view.backgroundColor = .yellow
        view.addSubview(backButton)
        view.addSubview(mainTitle)
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        scrollView.addSubview(secondMainTitle)
        scrollView.addSubview(thirdMainTitle)
        scrollView.addSubview(categoryStack)
        scrollView.addSubview(firstCategoryStack)
        scrollView.addSubview(secondCategoryStack)
        
    }
    
    func setupViews() {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        mainTitle.text = "Помощь"
        mainTitle.textAlignment = .center
        mainTitle.textColor = .purple
        mainTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        secondMainTitle.text = "Правила игры"
        secondMainTitle.textAlignment = .center
        secondMainTitle.textColor = .purple
        secondMainTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        startGameImage.image = UIImage(named: "startGameButton")
        
        mainStack.axis = .vertical
        mainStack.spacing = 30
        mainStack.alignment = .center
        mainStack.addArrangedSubview(firstStack)
        mainStack.addArrangedSubview(secondStack)
        mainStack.setCustomSpacing(2, after: secondStack)
        mainStack.addArrangedSubview(startGameImage)
        mainStack.setCustomSpacing(2, after: startGameImage)
        mainStack.addArrangedSubview(thirdtack)
        mainStack.addArrangedSubview(fourthStack)
        mainStack.addArrangedSubview(fiveStack)
        mainStack.addArrangedSubview(sixthStack)
        mainStack.addArrangedSubview(seventhStack)
        
        secondMainTitle.text = "Правила игры"
        secondMainTitle.textAlignment = .center
        secondMainTitle.textColor = .purple
        secondMainTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        thirdMainTitle.text = "Категории"
        thirdMainTitle.textColor = .purple
        thirdMainTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        categoryStack.axis = .vertical
        categoryStack.spacing = 55
        categoryStack.alignment = .center
        categoryStack.addArrangedSubview(firstCategoryLabel)
        categoryStack.addArrangedSubview(secondCategoryLabel)
        
        firstCategoryLabel.text = "В игре доступно 6 категорий и более 90 вопросов."
        firstCategoryLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        firstCategoryLabel.textAlignment = .center
        firstCategoryLabel.numberOfLines = 0
        firstCategoryLabel.lineBreakMode = .byWordWrapping
        
        secondCategoryLabel.text = "Можно выбрать сразу несколько категорий для игры."
        secondCategoryLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        secondCategoryLabel.textAlignment = .center
        secondCategoryLabel.numberOfLines = 0
        secondCategoryLabel.lineBreakMode = .byWordWrapping
        
        firstCategoryStack.axis = .horizontal
        firstCategoryStack.spacing = 4
        firstCategoryStack.alignment = .fill
        firstCategoryStack.distribution = .fillEqually
        firstCategoryStack.addArrangedSubview(natureCatImage)
        firstCategoryStack.addArrangedSubview(cinemaCatImage)
        
        secondCategoryStack.axis = .horizontal
        secondCategoryStack.spacing = 4
        secondCategoryStack.alignment = .fill
        secondCategoryStack.distribution = .fillEqually
        secondCategoryStack.addArrangedSubview(otherCatImage)
        secondCategoryStack.addArrangedSubview(sportCatImage)
        
        natureCatImage.image = UIImage(named: "nature")
        natureCatImage.contentMode = .scaleAspectFit
        
        cinemaCatImage.image = UIImage(named: "cinema")
        cinemaCatImage.contentMode = .scaleAspectFit
        
        otherCatImage.image = UIImage(named: "other")
        otherCatImage.contentMode = .scaleAspectFit
        
        sportCatImage.image = UIImage(named: "sport1")
        sportCatImage.contentMode = .scaleAspectFit
    }
    
    func createText() -> NSMutableAttributedString  {
        let stringOne = NSMutableAttributedString(string:"Если в настройках выбран режим игры ")
        let stringThree = NSMutableAttributedString(string:", то проигравший выполняет задание.")
        let stringAtr = [NSAttributedString.Key.foregroundColor : BombColor.violet.color.cgColor]
        let stringTow = NSMutableAttributedString(string: " “С Заданиями”", attributes: stringAtr)
        let finalString = NSMutableAttributedString()
        finalString.append(stringOne)
        finalString.append(stringTow)
        finalString.append(stringThree)
        return finalString
    }
    
    func createStack(text: String, number: Int) -> UIStackView {
        let view = UIView()
        let stack = UIStackView()
        let currentNumber = UILabel()
        let label = UILabel()
        
        view.backgroundColor = .purple
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 29 / 2
        view.clipsToBounds = true
        
        currentNumber.text = String(number)
        currentNumber.textColor = .yellow
        currentNumber.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
        view.addSubview(currentNumber)
        if number == 7 {
            label.attributedText = createText()
        } else {
            label.text = text
        }
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.addArrangedSubview(view)
        stack.addArrangedSubview(label)
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(29)
        }
        
        currentNumber.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        return stack
    }
    
    func setupConstraints() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(mainTitle.snp.centerY)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
            $0.bottom.equalToSuperview()
        }
        
        secondMainTitle.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.centerX.equalTo(scrollView.snp.centerX)
        }
        
        mainStack.snp.makeConstraints {
            $0.leading.trailing.equalTo(scrollView)
            $0.top.equalTo(secondMainTitle.snp.bottom).inset(-30)
        }
        
        startGameImage.snp.makeConstraints {
            $0.centerX.equalTo(mainStack.snp.centerX)
        }
        
        thirdMainTitle.snp.makeConstraints {
            $0.top.equalTo(mainStack.snp.bottom).offset(40)
            $0.centerX.equalTo(scrollView.snp.centerX)
        }
        
        categoryStack.snp.makeConstraints {
            $0.top.equalTo(thirdMainTitle.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        firstCategoryLabel.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        secondCategoryLabel.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        firstCategoryStack.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.top.equalTo(categoryStack.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        secondCategoryStack.snp.makeConstraints {
            $0.top.equalTo(firstCategoryStack.snp.bottom).offset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
    }
}
