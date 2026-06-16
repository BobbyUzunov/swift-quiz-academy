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
        CategoryDefinition(id: "ios-development", title: "iOS Development", description: "Apps, platform behavior, permissions and release basics.", icon: "iphone.gen3", color: .green, fileName: "ios_development"),
        CategoryDefinition(id: "programming-logic", title: "Programming Logic", description: "Conditions, loops, comparisons and problem solving.", icon: "brain.head.profile", color: .purple, fileName: "programming_logic"),
        CategoryDefinition(id: "ai-for-developers", title: "AI for Developers", description: "AI-assisted development, prompts, review and responsible use.", icon: "sparkles", color: .pink, fileName: "ai_for_developers"),
        CategoryDefinition(id: "git-github", title: "Git & GitHub", description: "Commits, branches, pull requests and collaboration workflows.", icon: "point.3.connected.trianglepath.dotted", color: .mint, fileName: "git_github"),
        CategoryDefinition(id: "architecture-mvvm", title: "Architecture & MVVM", description: "Separation of concerns, view models, services and testable design.", icon: "building.columns.fill", color: .indigo, fileName: "architecture_mvvm"),
        CategoryDefinition(id: "xcode-debugging", title: "Xcode & Debugging", description: "Build errors, breakpoints, Instruments and debugging workflows.", icon: "ladybug.fill", color: .red, fileName: "xcode_debugging")
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
            do {
                return try loadQuestions(fileName: definition.fileName)
            } catch {
                logLoadingError(error, fileName: definition.fileName)
                return []
            }
        }
    }

    func loadGroupedQuestions(for definition: CategoryDefinition) -> [Difficulty: [QuizQuestion]] {
        do {
            let questions = try loadQuestions(fileName: definition.fileName)
            return Self.groupByDifficulty(questions.filter { $0.categoryId == definition.id })
        } catch {
            logLoadingError(error, fileName: definition.fileName)
            return [:]
        }
    }

    func loadQuestions(fileName: String) throws -> [QuizQuestion] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw LoaderError.missingFile("\(fileName).json")
        }

        let data = try Data(contentsOf: url)
        let questions = try decoder.decode([QuizQuestion].self, from: data)
        let validQuestions = questions.filter(Self.isValidQuestion)

        #if DEBUG
        if validQuestions.count != questions.count {
            print("Swift Quiz Academy QuestionLoader skipped \(questions.count - validQuestions.count) invalid question(s) in \(fileName).json")
        }
        #endif

        return validQuestions
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
        question.answersBG.count == 4 &&
        question.answersEN.count == 4 &&
        question.answersBG.contains(question.correctAnswerBG) &&
        question.answersEN.contains(question.correctAnswerEN)
    }

    private func logLoadingError(_ error: Error, fileName: String) {
        #if DEBUG
        print("Swift Quiz Academy QuestionLoader failed to load \(fileName).json: \(error)")
        #endif
    }
}
