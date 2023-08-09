//
//  RulesView.swift
//  BombGame
//
//  Created by Кирилл Корнев on 08.08.2023.
//

import UIKit

final class RulesView: UIView {
    // MARK: - Views
    private lazy var backButton = UIButton(type: .system)
    private lazy var mainTitle = UILabel()
    private lazy var secondMainTitle = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var firstNumber = UILabel()

    private lazy var firstStack = createStack(text: "Все игроки становятся в круг.", number: 1)
    private lazy var secondStack = createStack(text: "Первый игрок берет телефон и нажимает кнопку:", number: 2)
    private lazy var startButton = UIButton()
    private lazy var thirdtack = createStack(text: "На экране появляется вопрос “Назовите Фрукт”.", number: 3)
    private lazy var fourthStack = createStack(text: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники).", number: 4)
    private lazy var fiveStack = createStack(text: "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.", number: 5)
    private lazy var sixthStack = createStack(text: "Проигравшим считается тот, в чьих руках взорвалась бомба.", number: 6)
    private lazy var seventhStack = createStack(text: "Если в настройках выбран режим игры “С Заданиями”, то проигравший выполняет задание.", number: 7)

    private lazy var mainStack = UIStackView()

    // MARK: - LifeCycle

    init() {
        super.init(frame: .zero)

        setup()
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension RulesView {
    func setup() {
        backgroundColor = .yellow
        addSubview(backButton)
        addSubview(mainTitle)
        addSubview(secondMainTitle)
        addSubview(scrollView)
        addSubview(mainStack)
    }

    func setupViews() {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black

        mainTitle.text = "Помощь"
        mainTitle.textColor = .purple
        mainTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        secondMainTitle.text = "Правила игры"
        secondMainTitle.textColor = .purple
        secondMainTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        startButton.setTitle("Старт игры", for: .normal)
        startButton.isUserInteractionEnabled = false
        startButton.backgroundColor = .purple
        startButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)

        
        scrollView.backgroundColor = .white
        scrollView.addSubview(mainStack)
        scrollView.addSubview(secondMainTitle)
        
//        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: 2000)

        mainStack.axis = .vertical
        mainStack.spacing = 30
        mainStack.alignment = .center
        mainStack.addArrangedSubview(firstStack)
        mainStack.addArrangedSubview(secondStack)
        mainStack.setCustomSpacing(2, after: secondStack)
        mainStack.addArrangedSubview(startButton)
        mainStack.addArrangedSubview(thirdtack)
        mainStack.addArrangedSubview(fourthStack)
        mainStack.addArrangedSubview(fiveStack)
        mainStack.addArrangedSubview(sixthStack)
        mainStack.addArrangedSubview(seventhStack)
    }

    func setupConstraints() {
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.centerX.equalToSuperview()
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(mainTitle.snp.centerY)
        }

        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(30)
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
        
        label.text = text
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
}

