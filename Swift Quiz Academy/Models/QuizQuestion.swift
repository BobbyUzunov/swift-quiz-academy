//
//  QuizQuestion.swift
//  Swift Quiz Academy
//

import Foundation

struct QuizQuestion: Codable, Identifiable {
    let id: String
    let categoryId: String
    let difficulty: Difficulty
    let questionBG: String
    let questionEN: String
    let answersBG: [String]
    let answersEN: [String]
    let correctAnswerBG: String
    let correctAnswerEN: String
    let explanationBG: String
    let explanationEN: String

    init(
        id: String,
        categoryId: String,
        difficulty: Difficulty,
        questionBG: String,
        questionEN: String,
        answersBG: [String],
        answersEN: [String],
        correctAnswerBG: String,
        correctAnswerEN: String,
        explanationBG: String,
        explanationEN: String
    ) {
        self.id = id
        self.categoryId = categoryId
        self.difficulty = difficulty
        self.questionBG = questionBG
        self.questionEN = questionEN
        self.answersBG = answersBG
        self.answersEN = answersEN
        self.correctAnswerBG = correctAnswerBG
        self.correctAnswerEN = correctAnswerEN
        self.explanationBG = explanationBG
        self.explanationEN = explanationEN
    }

    func questionText(for language: AppLanguage) -> String {
        switch language {
        case .bulgarian:
            return questionBG
        case .english:
            return questionEN
        }
    }

    func answers(for language: AppLanguage) -> [String] {
        switch language {
        case .bulgarian:
            return answersBG
        case .english:
            return answersEN
        }
    }

    func correctAnswerIndex(for language: AppLanguage) -> Int {
        switch language {
        case .bulgarian:
            return answersBG.firstIndex(of: correctAnswerBG) ?? 0
        case .english:
            return answersEN.firstIndex(of: correctAnswerEN) ?? 0
        }
    }

    func correctAnswerText(for language: AppLanguage) -> String {
        switch language {
        case .bulgarian:
            return correctAnswerBG
        case .english:
            return correctAnswerEN
        }
    }

    func explanationText(for language: AppLanguage) -> String {
        switch language {
        case .bulgarian:
            return explanationBG
        case .english:
            return explanationEN
        }
    }
}
