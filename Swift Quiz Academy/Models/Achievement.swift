//
//  Achievement.swift
//  Swift Quiz Academy
//

import Foundation

struct Achievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let isUnlocked: Bool

    static func all(unlockedIDs: Set<String>) -> [Achievement] {
        [
            Achievement(id: "first-quiz", title: "First Quiz", description: "Complete your first quiz.", icon: "flag.checkered", isUnlocked: unlockedIDs.contains("first-quiz")),
            Achievement(id: "perfect-score", title: "First Perfect Score", description: "Finish a quiz with 100% accuracy.", icon: "checkmark.seal.fill", isUnlocked: unlockedIDs.contains("perfect-score")),
            Achievement(id: "100-xp", title: "100 XP", description: "Reach 100 total XP.", icon: "bolt.fill", isUnlocked: unlockedIDs.contains("100-xp")),
            Achievement(id: "500-xp", title: "500 XP", description: "Reach 500 total XP.", icon: "bolt.circle.fill", isUnlocked: unlockedIDs.contains("500-xp")),
            Achievement(id: "10-games", title: "10 Games Played", description: "Play 10 quizzes.", icon: "gamecontroller.fill", isUnlocked: unlockedIDs.contains("10-games")),
            Achievement(id: "50-correct", title: "50 Correct Answers", description: "Answer 50 questions correctly.", icon: "target", isUnlocked: unlockedIDs.contains("50-correct"))
        ]
    }

    func title(for language: AppLanguage) -> String {
        switch id {
        case "first-quiz":
            return language.localized("Първи quiz", "First Quiz")
        case "perfect-score":
            return language.localized("Първи перфектен резултат", "First Perfect Score")
        case "100-xp":
            return language.localized("100 XP", "100 XP")
        case "500-xp":
            return language.localized("500 XP", "500 XP")
        case "10-games":
            return language.localized("10 изиграни игри", "10 Games Played")
        case "50-correct":
            return language.localized("50 правилни отговора", "50 Correct Answers")
        default:
            return title
        }
    }

    func description(for language: AppLanguage) -> String {
        switch id {
        case "first-quiz":
            return language.localized("Завърши първия си quiz.", "Complete your first quiz.")
        case "perfect-score":
            return language.localized("Завърши quiz със 100% успеваемост.", "Finish a quiz with 100% accuracy.")
        case "100-xp":
            return language.localized("Достигни 100 общо XP.", "Reach 100 total XP.")
        case "500-xp":
            return language.localized("Достигни 500 общо XP.", "Reach 500 total XP.")
        case "10-games":
            return language.localized("Изиграй 10 quiz-а.", "Play 10 quizzes.")
        case "50-correct":
            return language.localized("Отговори правилно на 50 въпроса.", "Answer 50 questions correctly.")
        default:
            return description
        }
    }
}
