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
            .advanced: [
                QuizQuestion(text: "Daily Swift: Which keyword creates an immutable value?", answers: ["var", "let", "mutating", "static"], correctAnswerIndex: 1),
                QuizQuestion(text: "Daily SwiftUI: Which wrapper stores simple local state?", answers: ["@State", "@Binding", "@SceneStorage", "@Environment"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily iOS: What does a Preview help you inspect?", answers: ["The app UI", "Only network logs", "App Store reviews", "Device storage"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Logic: What does an if statement use?", answers: ["A condition", "Only an image", "A file path", "A package name"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily AI: What is a prompt?", answers: ["Input for an AI system", "A screen size", "An app icon", "A compiler"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Swift: Which collection stores key-value pairs?", answers: ["Array", "Set", "Dictionary", "String"], correctAnswerIndex: 2),
                QuizQuestion(text: "Daily SwiftUI: Which layout places views horizontally?", answers: ["VStack", "HStack", "ZStack", "Spacer"], correctAnswerIndex: 1),
                QuizQuestion(text: "Daily iOS: What is the simulator used for?", answers: ["Running apps like a device", "Writing emails", "Editing icons only", "Deleting code"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily Logic: What does == check?", answers: ["Equality", "Assignment", "Importing", "Looping"], correctAnswerIndex: 0),
                QuizQuestion(text: "Daily AI: Why should AI output be checked?", answers: ["It can make mistakes", "It never uses data", "It cannot answer", "It only draws UI"], correctAnswerIndex: 0)
            ]
        ]
    )
}
