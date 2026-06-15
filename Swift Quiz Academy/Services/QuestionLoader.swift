//
//  QuestionLoader.swift
//  Swift Quiz Academy
//

import Foundation
import SwiftUI

struct QuestionLoader {
    struct CategoryDefinition {
        let id: String
        let title: String
        let description: String
        let icon: String
        let color: Color
        let fileName: String
    }

    enum LoaderError: Error {
        case missingFile(String)
    }

    static let categoryDefinitions: [CategoryDefinition] = [
        CategoryDefinition(id: "swift-basics", title: "Swift Basics", description: "Variables, types, functions and optionals.", icon: "swift", color: .orange, fileName: "swift_basics"),
        CategoryDefinition(id: "swiftui", title: "SwiftUI", description: "Views, state, modifiers and layout basics.", icon: "square.stack.3d.up.fill", color: .blue, fileName: "swiftui"),
        CategoryDefinition(id: "ios-basics", title: "iOS Basics", description: "Apps, screens, assets and Apple platform ideas.", icon: "iphone.gen3", color: .green, fileName: "ios_basics"),
        CategoryDefinition(id: "programming-logic", title: "Programming Logic", description: "Conditions, loops, comparisons and problem solving.", icon: "brain.head.profile", color: .purple, fileName: "programming_logic"),
        CategoryDefinition(id: "ai-basics", title: "AI Basics", description: "Core terms for modern AI and machine learning.", icon: "sparkles", color: .pink, fileName: "ai_basics")
    ]

    private let bundle: Bundle
    private let decoder: JSONDecoder

    init(bundle: Bundle = .main, decoder: JSONDecoder = JSONDecoder()) {
        self.bundle = bundle
        self.decoder = decoder
    }

    func loadCategories() -> [QuizCategory] {
        Self.categoryDefinitions.map { definition in
            QuizCategory(
                id: definition.id,
                title: definition.title,
                description: definition.description,
                icon: definition.icon,
                color: definition.color,
                questionsByDifficulty: loadGroupedQuestions(for: definition)
            )
        }
    }

    func loadAllQuestions() -> [QuizQuestion] {
        Self.categoryDefinitions.flatMap { definition in
            (try? loadQuestions(fileName: definition.fileName)) ?? []
        }
    }

    func loadGroupedQuestions(for definition: CategoryDefinition) -> [Difficulty: [QuizQuestion]] {
        guard let questions = try? loadQuestions(fileName: definition.fileName) else {
            return [:]
        }
        return Self.groupByDifficulty(questions.filter { $0.categoryId == definition.id })
    }

    func loadQuestions(fileName: String) throws -> [QuizQuestion] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw LoaderError.missingFile("\(fileName).json")
        }

        let data = try Data(contentsOf: url)
        let questions = try decoder.decode([QuizQuestion].self, from: data)
        return questions.filter(Self.isValidQuestion)
    }

    nonisolated static func groupByCategoryAndDifficulty(_ questions: [QuizQuestion]) -> [String: [Difficulty: [QuizQuestion]]] {
        Dictionary(grouping: questions, by: \.categoryId).mapValues(groupByDifficulty)
    }

    nonisolated static func groupByDifficulty(_ questions: [QuizQuestion]) -> [Difficulty: [QuizQuestion]] {
        Dictionary(grouping: questions, by: \.difficulty)
    }

    nonisolated private static func isValidQuestion(_ question: QuizQuestion) -> Bool {
        !question.id.isEmpty &&
        !question.categoryId.isEmpty &&
        !question.questionBG.isEmpty &&
        !question.questionEN.isEmpty &&
        question.answersBG.count >= 2 &&
        question.answersEN.count >= 2 &&
        question.answersBG.contains(question.correctAnswerBG) &&
        question.answersEN.contains(question.correctAnswerEN)
    }
}
