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
    var completedQuestionIDsByCategory: [String: Set<String>]
    var favoriteQuestionIDs: Set<String>
    var librarySearchesPerformed: Int
}

final class QuizProgressStore {
    static let currentSchemaVersion = 1

    private enum Key {
        static let schemaVersion = "persistenceSchemaVersion"
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
        static let completedQuestionsByCategory = "completedQuestionsByCategory"
        static let favoriteQuestionIDs = "favoriteQuestionIDs"
        static let librarySearchesPerformed = "librarySearchesPerformed"

        static let all = [
            schemaVersion,
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
            achievements,
            completedQuestionsByCategory,
            favoriteQuestionIDs,
            librarySearchesPerformed
        ]
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        migrateIfNeeded()
    }

    var storedSchemaVersion: Int {
        userDefaults.integer(forKey: Key.schemaVersion)
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
            achievementIDs: Set(userDefaults.stringArray(forKey: Key.achievements) ?? []),
            completedQuestionIDsByCategory: loadCompletedQuestionsByCategory(),
            favoriteQuestionIDs: Set(userDefaults.stringArray(forKey: Key.favoriteQuestionIDs) ?? []),
            librarySearchesPerformed: userDefaults.integer(forKey: Key.librarySearchesPerformed)
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

    func saveCompletedQuestionsByCategory(_ completedQuestionsByCategory: [String: Set<String>]) {
        let codableValue = completedQuestionsByCategory.mapValues { Array($0).sorted() }
        saveCodableValue(codableValue, key: Key.completedQuestionsByCategory)
    }

    func saveFavoriteQuestionIDs(_ favoriteQuestionIDs: Set<String>) {
        userDefaults.set(Array(favoriteQuestionIDs).sorted(), forKey: Key.favoriteQuestionIDs)
    }

    func saveLibrarySearchesPerformed(_ searchesPerformed: Int) {
        userDefaults.set(searchesPerformed, forKey: Key.librarySearchesPerformed)
    }

    func reset() {
        Key.all.forEach { userDefaults.removeObject(forKey: $0) }
        saveCurrentSchemaVersion()
    }

    private func saveCodableArray<T: Encodable>(_ values: [T], key: String) {
        saveCodableValue(values, key: key)
    }

    private func saveCodableValue<T: Encodable>(_ value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            #if DEBUG
            print("Swift Quiz Academy persistence encode failed for \(key): \(error)")
            #endif
        }
    }

    private func loadCodableArray<T: Decodable>(_ type: T.Type, key: String) -> [T] {
        guard let data = userDefaults.data(forKey: key) else {
            return []
        }

        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            #if DEBUG
            print("Swift Quiz Academy persistence decode failed for \(key): \(error)")
            #endif
            return []
        }
    }

    private func loadCompletedQuestionsByCategory() -> [String: Set<String>] {
        let stored: [String: [String]] = loadCodableValue([String: [String]].self, key: Key.completedQuestionsByCategory) ?? [:]
        return stored.mapValues(Set.init)
    }

    private func loadCodableValue<T: Decodable>(_ type: T.Type, key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            #if DEBUG
            print("Swift Quiz Academy persistence decode failed for \(key): \(error)")
            #endif
            return nil
        }
    }

    private func migrateIfNeeded() {
        let storedVersion = userDefaults.integer(forKey: Key.schemaVersion)
        guard storedVersion < Self.currentSchemaVersion else { return }

        #if DEBUG
        print("Swift Quiz Academy persistence migration: \(storedVersion) -> \(Self.currentSchemaVersion)")
        #endif

        saveCurrentSchemaVersion()
    }

    private func saveCurrentSchemaVersion() {
        userDefaults.set(Self.currentSchemaVersion, forKey: Key.schemaVersion)
    }
}
