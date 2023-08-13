//
//  GamePresenter.swift
//  BombGame
//
//  Created by Келлер Дмитрий on 08.08.2023.
//

import Foundation

final class GamePresenter {
    
    weak var view: GameViewInput?
    var questions: [String] = []
    var currentQuestion: String = ""
    
    private let router: GameRouterInput
    private let settingsManager: SettingsManagerProtocol
    private let questionsManager: QuestionsManagerProtocol
    
    init(router: GameRouterInput, settingsManager: SettingsManagerProtocol, questionsManager: QuestionsManagerProtocol) {
        
        self.router = router
        self.settingsManager = settingsManager
        self.questionsManager = questionsManager
        
    }
}

extension GamePresenter: GameViewOutput {
    
    
    func getQuestionsArray() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "loadGame") == nil {
            questionsManager.getSavedQuestions { result in
                switch result {
                case .success(let questions):
                    self.questions = questions
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            questions = questionsManager.getQuestionsShuffleArray(categories: getSelectedCategories())
        }
        
    }
    
    func startTimer() {
        view?.addTimer()
    }
    
    func pauseButtonTapped() {
        view?.updateTimerAnimation()
    }
    
    func startButtonTapped() {
        view?.updateGameUI()
    }
    
    func homeButtonTapped() {
        self.router.routeToStartScreen()
    }
    
    func getSelectedCategories() -> [Categories]{
        var tmpCategories: [Categories] = []
        for (key, _) in SelectedCategories.categories {
            tmpCategories.append(key)
        }
        return tmpCategories
    }
    
    func getQuestion() -> String {
        
        var question: String = ""
        if questions.count != 0 {
            question = questions[0]
            currentQuestion = question
            questions.remove(at: 0)
            questionsManager.saveCurrentQuestionsArray(questions: questions)
        } else {
            getQuestionsArray()
        }
        
        return question
        
    }
}
