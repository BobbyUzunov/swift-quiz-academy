//
//  QuizCategory.swift
//  Swift Quiz Academy
//

import SwiftUI

struct QuizCategory: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let color: Color
    let questionsByDifficulty: [Difficulty: [QuizQuestion]]

    var totalQuestionCount: Int {
        questionsByDifficulty.values.reduce(0) { $0 + $1.count }
    }

    func questionCount(for difficulty: Difficulty) -> Int {
        questionsByDifficulty[difficulty]?.count ?? 0
    }

    func title(for language: AppLanguage) -> String {
        switch id {
        case "swift-basics":
            return language.localized("Swift основи", "Swift Basics")
        case "swiftui":
            return language.localized("SwiftUI", "SwiftUI")
        case "ios-development":
            return language.localized("iOS разработка", "iOS Development")
        case "programming-logic":
            return language.localized("Програмна логика", "Programming Logic")
        case "ai-for-developers":
            return language.localized("AI за разработчици", "AI for Developers")
        case "git-github":
            return language.localized("Git и GitHub", "Git & GitHub")
        case "architecture-mvvm":
            return language.localized("Архитектура и MVVM", "Architecture & MVVM")
        case "xcode-debugging":
            return language.localized("Xcode и debugging", "Xcode & Debugging")
        case "daily-challenge":
            return language.localized("Дневно предизвикателство", "Daily Challenge")
        case "practice-mistakes":
            return language.localized("Упражнявай грешките", "Practice Mistakes")
        default:
            return title
        }
    }

    func description(for language: AppLanguage) -> String {
        switch id {
        case "swift-basics":
            return language.localized("Променливи, типове, функции и optional-и.", "Variables, types, functions and optionals.")
        case "swiftui":
            return language.localized("Views, state, modifiers и основи на layout.", "Views, state, modifiers and layout basics.")
        case "ios-development":
            return language.localized("Apps, platform поведение, permissions и release основи.", "Apps, platform behavior, permissions and release basics.")
        case "programming-logic":
            return language.localized("Условия, цикли, сравнения и решаване на проблеми.", "Conditions, loops, comparisons and problem solving.")
        case "ai-for-developers":
            return language.localized("AI-assisted разработка, prompts, review и отговорна употреба.", "AI-assisted development, prompts, review and responsible use.")
        case "git-github":
            return language.localized("Commits, branches, pull requests и collaboration workflows.", "Commits, branches, pull requests and collaboration workflows.")
        case "architecture-mvvm":
            return language.localized("Separation of concerns, view models, services и testable design.", "Separation of concerns, view models, services and testable design.")
        case "xcode-debugging":
            return language.localized("Build errors, breakpoints, Instruments и debugging workflows.", "Build errors, breakpoints, Instruments and debugging workflows.")
        case "daily-challenge":
            return language.localized("Един специален смесен quiz на ден с bonus XP.", "One special mixed quiz per day with bonus XP.")
        case "practice-mistakes":
            return language.localized("Преговори въпросите, на които си отговорил грешно.", "Review questions you answered incorrectly.")
        default:
            return description
        }
    }

    static let allCategories: [QuizCategory] = QuestionLoader().loadCategories()

    static let dailyChallenge = QuizCategory(
        id: "daily-challenge",
        title: "Daily Challenge",
        description: "One special mixed quiz per day with bonus XP.",
        icon: "calendar.badge.clock",
        color: .orange,
        questionsByDifficulty: [
            .advanced: Self.makeDailyChallengeQuestions()
        ]
    )

    private static func makeDailyChallengeQuestions() -> [QuizQuestion] {
        let categoryQuestions = allCategories.compactMap { category in
            Difficulty.allCases.compactMap { difficulty in
                category.questionsByDifficulty[difficulty]?.first
            }.first
        }

        let extraQuestions = allCategories.flatMap { category in
            Difficulty.allCases.flatMap { difficulty in
                category.questionsByDifficulty[difficulty] ?? []
            }
        }
        .filter { question in
            !categoryQuestions.contains { $0.id == question.id }
        }
        .prefix(2)

        return categoryQuestions + Array(extraQuestions)
    }
}
