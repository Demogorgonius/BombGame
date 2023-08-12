//
//  QuestionsError.swift
//  BombGame
//
//  Created by Sergey on 11.08.2023.
//

import Foundation

enum QuestionsErrors: Error {
    case savedQuestionEmpty
    case saveSettingsError
    case getSettingsError
}

extension QuestionsErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .savedQuestionEmpty:
            return NSLocalizedString("У Вас нет сохраненной игры!", comment: "Начните игру заново!")
        case .saveSettingsError:
            return NSLocalizedString("Ошибка сохранения настроек игры!", comment: "Попробуйте еще раз!")
        case .getSettingsError:
            return NSLocalizedString("Ошибка чтения настроек игры!", comment: "Попробуйте еще раз!")
       
        }
    }
}
