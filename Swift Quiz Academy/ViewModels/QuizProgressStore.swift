//
//  QuizProgressStore.swift
//  Swift Quiz Academy
//

import Foundation

struct QuizProgressSnapshot {
    var totalXP: Int
    var highestScore: Int
    var totalGamesPlayed: Int
    var bestStreak: Int
    var correctAnswers: Int
    var wrongAnswers: Int
    var currentDailyStreak: Int
    var bestDailyStreak: Int
    var lastCategoryID: String
    var lastDifficulty: Difficulty
    var lastDailyChallengeDate: String
    var lastDailyRewardDate: String
    var currentLoginStreak: Int
    var bestLoginStreak: Int
    var lastPlayDate: String
    var selectedLanguage: AppLanguage
    var selectedTheme: AppTheme
    var mistakes: [MistakeRecord]
    var achievementIDs: Set<String>
}

final class QuizProgressStore {
    private enum Key {
        static let totalXP = "totalXP"
        static let highestScore = "highestScore"
        static let totalGamesPlayed = "totalGamesPlayed"
        static let bestStreak = "bestStreak"
        static let correctAnswers = "correctAnswers"
        static let wrongAnswers = "wrongAnswers"
        static let currentDailyStreak = "currentDailyStreak"
        static let bestDailyStreak = "bestDailyStreak"
        static let lastPlayDate = "lastPlayDate"
        static let mistakes = "mistakes"
        static let achievements = "achievements"
        static let lastCategoryID = "lastCategoryID"
        static let lastDifficulty = "lastDifficulty"
        static let lastDailyChallengeDate = "lastDailyChallengeDate"
        static let lastDailyRewardDate = "lastDailyRewardDate"
        static let currentLoginStreak = "currentLoginStreak"
        static let bestLoginStreak = "bestLoginStreak"
        static let selectedLanguage = "selectedLanguage"
        static let selectedTheme = "selectedTheme"

        static let all = [
            totalXP,
            highestScore,
            totalGamesPlayed,
            bestStreak,
            correctAnswers,
            wrongAnswers,
            currentDailyStreak,
            bestDailyStreak,
            lastCategoryID,
            lastDifficulty,
            lastDailyChallengeDate,
            lastDailyRewardDate,
            currentLoginStreak,
            bestLoginStreak,
            lastPlayDate,
            selectedLanguage,
            selectedTheme,
            mistakes,
            achievements
        ]
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func load() -> QuizProgressSnapshot {
        let lastDifficulty = userDefaults.string(forKey: Key.lastDifficulty)
            .flatMap(Difficulty.init(rawValue:)) ?? .beginner
        let selectedLanguage = userDefaults.string(forKey: Key.selectedLanguage)
            .flatMap(AppLanguage.init(rawValue:)) ?? .english
        let selectedTheme = userDefaults.string(forKey: Key.selectedTheme)
            .flatMap(AppTheme.init(rawValue:)) ?? .system

        return QuizProgressSnapshot(
            totalXP: userDefaults.integer(forKey: Key.totalXP),
            highestScore: userDefaults.integer(forKey: Key.highestScore),
            totalGamesPlayed: userDefaults.integer(forKey: Key.totalGamesPlayed),
            bestStreak: userDefaults.integer(forKey: Key.bestStreak),
            correctAnswers: userDefaults.integer(forKey: Key.correctAnswers),
            wrongAnswers: userDefaults.integer(forKey: Key.wrongAnswers),
            currentDailyStreak: userDefaults.integer(forKey: Key.currentDailyStreak),
            bestDailyStreak: userDefaults.integer(forKey: Key.bestDailyStreak),
            lastCategoryID: userDefaults.string(forKey: Key.lastCategoryID) ?? "",
            lastDifficulty: lastDifficulty,
            lastDailyChallengeDate: userDefaults.string(forKey: Key.lastDailyChallengeDate) ?? "",
            lastDailyRewardDate: userDefaults.string(forKey: Key.lastDailyRewardDate) ?? "",
            currentLoginStreak: userDefaults.integer(forKey: Key.currentLoginStreak),
            bestLoginStreak: userDefaults.integer(forKey: Key.bestLoginStreak),
            lastPlayDate: userDefaults.string(forKey: Key.lastPlayDate) ?? "",
            selectedLanguage: selectedLanguage,
            selectedTheme: selectedTheme,
            mistakes: loadCodableArray(MistakeRecord.self, key: Key.mistakes),
            achievementIDs: Set(userDefaults.stringArray(forKey: Key.achievements) ?? [])
        )
    }

    func saveLanguage(_ language: AppLanguage) {
        userDefaults.set(language.rawValue, forKey: Key.selectedLanguage)
    }

    func saveTheme(_ theme: AppTheme) {
        userDefaults.set(theme.rawValue, forKey: Key.selectedTheme)
    }

    func saveLastSelection(categoryID: String, difficulty: Difficulty) {
        userDefaults.set(categoryID, forKey: Key.lastCategoryID)
        userDefaults.set(difficulty.rawValue, forKey: Key.lastDifficulty)
    }

    func saveDailyChallengeDate(_ date: String) {
        userDefaults.set(date, forKey: Key.lastDailyChallengeDate)
    }

    func saveDailyReward(date: String, currentStreak: Int, bestStreak: Int, totalXP: Int) {
        userDefaults.set(date, forKey: Key.lastDailyRewardDate)
        userDefaults.set(currentStreak, forKey: Key.currentLoginStreak)
        userDefaults.set(bestStreak, forKey: Key.bestLoginStreak)
        userDefaults.set(totalXP, forKey: Key.totalXP)
    }

    func saveTotals(
        totalXP: Int,
        highestScore: Int,
        totalGamesPlayed: Int,
        bestStreak: Int,
        correctAnswers: Int,
        wrongAnswers: Int
    ) {
        userDefaults.set(totalXP, forKey: Key.totalXP)
        userDefaults.set(highestScore, forKey: Key.highestScore)
        userDefaults.set(totalGamesPlayed, forKey: Key.totalGamesPlayed)
        userDefaults.set(bestStreak, forKey: Key.bestStreak)
        userDefaults.set(correctAnswers, forKey: Key.correctAnswers)
        userDefaults.set(wrongAnswers, forKey: Key.wrongAnswers)
    }

    func saveDailyStreak(current: Int, best: Int, lastPlayDate: String) {
        userDefaults.set(current, forKey: Key.currentDailyStreak)
        userDefaults.set(best, forKey: Key.bestDailyStreak)
        userDefaults.set(lastPlayDate, forKey: Key.lastPlayDate)
    }

    func saveMistakes(_ mistakes: [MistakeRecord]) {
        saveCodableArray(mistakes, key: Key.mistakes)
    }

    func saveAchievements(_ achievementIDs: Set<String>) {
        userDefaults.set(Array(achievementIDs), forKey: Key.achievements)
    }

    func reset() {
        Key.all.forEach { userDefaults.removeObject(forKey: $0) }
    }

    private func saveCodableArray<T: Encodable>(_ values: [T], key: String) {
        if let data = try? JSONEncoder().encode(values) {
            userDefaults.set(data, forKey: key)
        }
    }

    private func loadCodableArray<T: Decodable>(_ type: T.Type, key: String) -> [T] {
        guard let data = userDefaults.data(forKey: key),
              let values = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return values
    }
}
