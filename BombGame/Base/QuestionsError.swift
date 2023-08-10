//
//  QuestionsError.swift
//  BombGame
//
//  Created by Sergey on 11.08.2023.
//

import Foundation

enum QuestionsErrors: Error {
    case savedQuestionEmpty
}

extension QuestionsErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .savedQuestionEmpty:
            return NSLocalizedString("У Вас нет сохраненной игры!", comment: "Начните игру заново!")
       
        }
    }
}
