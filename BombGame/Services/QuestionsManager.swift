//
//  QuestionsManager.swift
//  BombGame
//
//  Created by Sergey on 11.08.2023.
//

import Foundation

protocol QuestionsManagerProtocol: AnyObject {
    
    func getQuestionsShuffleArray(categories: [Categories]) -> [String]
    func saveCurrentQuestionsArray(questions: [String])
    func getSavedQuestions(completionBlock: @escaping(Result<[String],Error>)-> Void)
    func getRandomPunishment() -> String
    
}

class QuestionsManager: QuestionsManagerProtocol {
    
    
    let defaults = UserDefaults.standard
    
    let questions = Questions()
    
    func getQuestionsShuffleArray(categories: [Categories]) -> [String] {
        
        var finalArray: [String] = []
        for category in categories {
            switch category {
            case .geography:
                finalArray.append(contentsOf: questions.geography.shuffled())
            case .literature:
                finalArray.append(contentsOf: questions.literature.shuffled())
            case .music:
                finalArray.append(contentsOf: questions.music.shuffled())
            case .food:
                finalArray.append(contentsOf: questions.food.shuffled())
            case .other:
                finalArray.append(contentsOf: questions.other.shuffled())
            case .internet:
                finalArray.append(contentsOf: questions.internet.shuffled())
            }
        }
        return finalArray.shuffled()
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

