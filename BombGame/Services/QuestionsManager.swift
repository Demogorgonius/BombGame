//
//  QuestionsManager.swift
//  BombGame
//
//  Created by Sergey on 11.08.2023.
//

import Foundation

protocol QuestionsManagerProtocol: AnyObject {
    
    func getQuestionsShuffleArray(category: Categories) -> [String]
    func saveCurrentQuestionsArray(questions: [String])
    func getSavedQuestions(completionBlock: @escaping(Result<[String],Error>)-> Void)
    func getRandomPunishment() -> String
    
}

class QuestionsManager: QuestionsManagerProtocol {
    
    
    let defaults = UserDefaults.standard
    
    let questions = Questions()
    
    func getQuestionsShuffleArray(category: Categories) -> [String] {
        
        
        
        switch category {
        case .geography:
            return questions.geography.shuffled()
        case .literature:
            return questions.literature.shuffled()
        case .music:
            return questions.music.shuffled()
        case .food:
            return questions.food.shuffled()
        case .other:
            return questions.other.shuffled()
        case .internet:
            return questions.internet.shuffled()
        }
    }
    
    func saveCurrentQuestionsArray(questions: [String]) {
        defaults.set(questions, forKey: "savedQuestions")
    }
    
    func getSavedQuestions(completionBlock: @escaping(Result<[String],Error>)-> Void) {
        if let array = defaults.object(forKey: "savedQuestions") as? [String] {
            completionBlock(.success(array))
        } else {
            completionBlock(.failure(QuestionsErrors.savedQuestionEmpty))
        }
    }
    
    func getRandomPunishment() -> String {
        return questions.punishments.randomElement()!
    }
    
}

