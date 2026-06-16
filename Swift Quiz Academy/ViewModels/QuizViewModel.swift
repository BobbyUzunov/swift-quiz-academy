//
//  QuizViewModel.swift
//  Swift Quiz Academy
//

import Foundation
import Observation
import SwiftUI

struct MistakeRecord: Codable, Identifiable, Hashable {
    var id: String {
        if !questionID.isEmpty {
            return questionID
        }
        return "\(categoryID)|\(difficultyRawValue)|\(questionEN)"
    }
    let questionID: String
    let questionEN: String
    let categoryID: String
    let difficultyRawValue: String

    init(questionID: String, questionEN: String = "", categoryID: String, difficultyRawValue: String) {
        self.questionID = questionID
        self.questionEN = questionEN
        self.categoryID = categoryID
        self.difficultyRawValue = difficultyRawValue
    }

    private enum CodingKeys: String, CodingKey {
        case questionID
        case questionEN
        case categoryID
        case difficultyRawValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        questionID = try container.decodeIfPresent(String.self, forKey: .questionID) ?? ""
        questionEN = try container.decodeIfPresent(String.self, forKey: .questionEN) ?? ""
        categoryID = try container.decode(String.self, forKey: .categoryID)
        difficultyRawValue = try container.decode(String.self, forKey: .difficultyRawValue)
    }
}

struct CategoryMasteryStat: Identifiable, Hashable {
    let id: String
    let title: String
    let totalQuestions: Int
    let completedQuestions: Int

    var masteryPercentage: Int {
        guard totalQuestions > 0 else { return 0 }
        return Int((Double(completedQuestions) / Double(totalQuestions) * 100).rounded())
    }
}

@Observable
final class QuizViewModel {
    private struct LevelMilestone {
        let level: Int
        let xp: Int
    }

    private static let levelMilestones: [LevelMilestone] = [
        LevelMilestone(level: 1, xp: 0),
        LevelMilestone(level: 2, xp: 100),
        LevelMilestone(level: 3, xp: 250),
        LevelMilestone(level: 4, xp: 500),
        LevelMilestone(level: 5, xp: 1000),
        LevelMilestone(level: 6, xp: 1500),
        LevelMilestone(level: 7, xp: 2500),
        LevelMilestone(level: 8, xp: 4000),
        LevelMilestone(level: 9, xp: 6000),
        LevelMilestone(level: 10, xp: 10000)
    ]

    let categories = QuizCategory.allCategories
    let dailyBonusXP = 50
    let dailyRewardXP = 25

    var screen: AppScreen = .start
    var selectedCategory: QuizCategory?
    var selectedDifficulty: Difficulty = .beginner
    var selectedLanguage: AppLanguage = .english {
        didSet { progressStore.saveLanguage(selectedLanguage) }
    }
    var selectedTheme: AppTheme = .system {
        didSet { progressStore.saveTheme(selectedTheme) }
    }
    var currentQuestionIndex = 0
    var selectedAnswerIndex: Int?
    var shuffledAnswerOptions: [AnswerOption] = []
    var reviewItems: [QuizReviewItem] = []
    var score = 0
    var xp = 0
    var lives = 3
    var streak = 0
    var bestStreakThisGame = 0
    var correctAnswersThisGame = 0
    var wrongAnswersThisGame = 0
    var feedbackMessage: String?
    var feedbackIsCorrect: Bool?
    var dailyBonusAwarded = 0
    var savedTotalXP: Int
    var savedHighestScore: Int
    var savedTotalGamesPlayed: Int
    var savedBestStreak: Int
    var savedCorrectAnswers: Int
    var savedWrongAnswers: Int
    var savedCurrentDailyStreak: Int
    var savedBestDailyStreak: Int
    var savedCurrentLoginStreak: Int
    var savedBestLoginStreak: Int
    var savedLastCategoryID: String
    var savedLastDifficulty: Difficulty
    var lastDailyChallengeDate: String
    var lastDailyRewardDate: String
    var savedLastPlayDate: String
    var mistakeRecords: [MistakeRecord]
    var unlockedAchievementIDs: Set<String>
    var completedQuestionIDsByCategory: [String: Set<String>]
    var availableDailyReward: DailyRewardResult?
    var recentAchievementID: String?

    private var hasSavedCurrentGame = false
    private var isDailyChallenge = false
    private var isPracticeMistakes = false
    private var practiceMistakeQuestions: [QuizQuestion] = []
    private var practiceMistakeRecords: [MistakeRecord] = []
    private let progressStore: QuizProgressStore
    private let dailyRewardManager: DailyRewardManager

    init(userDefaults: UserDefaults = .standard) {
        progressStore = QuizProgressStore(userDefaults: userDefaults)
        dailyRewardManager = DailyRewardManager()
        let progress = progressStore.load()
        savedTotalXP = progress.totalXP
        savedHighestScore = progress.highestScore
        savedTotalGamesPlayed = progress.totalGamesPlayed
        savedBestStreak = progress.bestStreak
        savedCorrectAnswers = progress.correctAnswers
        savedWrongAnswers = progress.wrongAnswers
        savedCurrentDailyStreak = progress.currentDailyStreak
        savedBestDailyStreak = progress.bestDailyStreak
        savedCurrentLoginStreak = progress.currentLoginStreak
        savedBestLoginStreak = progress.bestLoginStreak
        savedLastCategoryID = progress.lastCategoryID
        savedLastDifficulty = progress.lastDifficulty
        selectedDifficulty = progress.lastDifficulty
        lastDailyChallengeDate = progress.lastDailyChallengeDate
        lastDailyRewardDate = progress.lastDailyRewardDate
        savedLastPlayDate = progress.lastPlayDate
        selectedLanguage = progress.selectedLanguage
        selectedTheme = progress.selectedTheme
        mistakeRecords = progress.mistakes
        unlockedAchievementIDs = progress.achievementIDs
        completedQuestionIDsByCategory = progress.completedQuestionIDsByCategory
        availableDailyReward = dailyRewardManager.claimReward(
            lastRewardDate: lastDailyRewardDate,
            currentStreak: savedCurrentLoginStreak,
            bestStreak: savedBestLoginStreak
        )

        migrateMistakeRecordsIfNeeded()
        updateAchievements()
    }

    var currentQuestions: [QuizQuestion] {
        if isPracticeMistakes { return practiceMistakeQuestions }
        guard let selectedCategory else { return [] }
        return selectedCategory.questionsByDifficulty[selectedDifficulty] ?? []
    }

    var currentQuestion: QuizQuestion? {
        guard currentQuestions.indices.contains(currentQuestionIndex) else { return nil }
        return currentQuestions[currentQuestionIndex]
    }

    var isLastQuestion: Bool { currentQuestionIndex == currentQuestions.count - 1 }

    var progressValue: Double {
        guard !currentQuestions.isEmpty else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(currentQuestions.count)
    }

    var isDailyChallengeAvailable: Bool { lastDailyChallengeDate != todayKey }

    var resultPercentage: Int {
        guard !currentQuestions.isEmpty else { return 0 }
        return Int((Double(score) / Double(currentQuestions.count) * 100).rounded())
    }

    var accuracyPercentage: Int {
        let totalAnswers = savedCorrectAnswers + savedWrongAnswers
        guard totalAnswers > 0 else { return 0 }
        return Int((Double(savedCorrectAnswers) / Double(totalAnswers) * 100).rounded())
    }

    var currentLevel: Int {
        currentLevelMilestone.level
    }

    var currentLevelTitle: String {
        switch currentLevel {
        case 1: return localized("Swift начинаещ", "Swift Beginner")
        case 2: return localized("Swift учащ", "Swift Learner")
        case 3: return localized("Swift изследовател", "Swift Explorer")
        case 4: return localized("Swift създател", "Swift Builder")
        case 5: return localized("Swift разработчик", "Swift Developer")
        case 6: return localized("Swift специалист", "Swift Specialist")
        case 7: return localized("Swift експерт", "Swift Expert")
        case 8: return localized("Swift архитект", "Swift Architect")
        case 9: return localized("Swift майстор", "Swift Master")
        default: return localized("Swift легенда", "Swift Legend")
        }
    }

    var currentLevelXP: Int { currentLevelMilestone.xp }

    var nextLevelXP: Int {
        nextLevelMilestone?.xp ?? currentLevelXP
    }

    var xpProgress: Double {
        guard let nextLevelMilestone else { return 1 }
        let levelRange = nextLevelMilestone.xp - currentLevelXP
        guard levelRange > 0 else { return 1 }
        let earnedInLevel = savedTotalXP - currentLevelXP
        return min(max(Double(earnedInLevel) / Double(levelRange), 0), 1)
    }

    var xpToNextLevel: Int {
        max(nextLevelXP - savedTotalXP, 0)
    }

    var achievements: [Achievement] { Achievement.all(unlockedIDs: unlockedAchievementIDs) }

    var recentAchievement: Achievement? {
        guard let recentAchievementID else { return nil }
        return achievements.first { $0.id == recentAchievementID }
    }

    var hasMistakes: Bool { !mistakeRecords.isEmpty }

    var totalCategoryCount: Int { categories.count }

    var totalQuestionCount: Int {
        categories.reduce(0) { $0 + $1.totalQuestionCount }
    }

    var categoryMasteryStats: [CategoryMasteryStat] {
        categories.map { category in
            let completedIDs = completedQuestionIDsByCategory[category.id] ?? []
            let validQuestionIDs = Set(category.questionsByDifficulty.values.flatMap { $0.map(\.id) })
            let completedCount = completedIDs.intersection(validQuestionIDs).count

            return CategoryMasteryStat(
                id: category.id,
                title: category.title(for: selectedLanguage),
                totalQuestions: category.totalQuestionCount,
                completedQuestions: completedCount
            )
        }
    }

    private var currentLevelMilestone: LevelMilestone {
        Self.levelMilestones.last { savedTotalXP >= $0.xp } ?? Self.levelMilestones[0]
    }

    private var nextLevelMilestone: LevelMilestone? {
        Self.levelMilestones.first { $0.xp > savedTotalXP }
    }

    func showCategories() { screen = .categories }

    func showReviewAnswers() { screen = .reviewAnswers }

    func returnToResults() { screen = .result }

    func startQuiz(with category: QuizCategory) {
        isDailyChallenge = false
        isPracticeMistakes = false
        selectedCategory = category
        saveLastSelection(categoryID: category.id, difficulty: selectedDifficulty)
        restartQuizState()
        screen = .quiz
    }

    func startDailyChallenge() {
        guard isDailyChallengeAvailable else { return }
        isDailyChallenge = true
        isPracticeMistakes = false
        selectedCategory = .dailyChallenge
        selectedDifficulty = .advanced
        saveLastSelection(categoryID: QuizCategory.dailyChallenge.id, difficulty: .advanced)
        restartQuizState()
        screen = .quiz
    }

    func startPracticeMistakes() -> Bool {
        let practiceItems: [(record: MistakeRecord, question: QuizQuestion)] = mistakeRecords.compactMap { record in
            guard let difficulty = Difficulty(rawValue: record.difficultyRawValue),
                  let question = findQuestion(for: record, categoryID: record.categoryID, difficulty: difficulty) else {
                return nil
            }
            return (normalizedMistakeRecord(for: question, categoryID: record.categoryID, difficulty: difficulty), question)
        }

        if practiceItems.count != mistakeRecords.count {
            mistakeRecords = practiceItems.map(\.record)
            progressStore.saveMistakes(mistakeRecords)
        }

        guard !practiceItems.isEmpty else { return false }

        let questions = practiceItems.map(\.question)
        practiceMistakeRecords = practiceItems.map(\.record)
        isDailyChallenge = false
        isPracticeMistakes = true
        practiceMistakeQuestions = questions
        selectedCategory = QuizCategory(
            id: "practice-mistakes",
            title: "Practice Mistakes",
            description: "Review questions you answered incorrectly.",
            icon: "exclamationmark.triangle.fill",
            color: .red,
            questionsByDifficulty: [selectedDifficulty: questions]
        )
        restartQuizState()
        screen = .quiz
        return true
    }

    func restartCurrentQuiz() {
        if isDailyChallenge && !isDailyChallengeAvailable {
            returnToStart()
            return
        }
        restartQuizState()
        screen = .quiz
    }

    func returnToStart() {
        screen = .start
        selectedCategory = nil
        selectedDifficulty = .beginner
        isDailyChallenge = false
        isPracticeMistakes = false
        practiceMistakeQuestions = []
        practiceMistakeRecords = []
        restartQuizState()
    }

    func selectAnswer(_ index: Int) {
        guard selectedAnswerIndex == nil,
              let currentQuestion,
              shuffledAnswerOptions.indices.contains(index) else { return }

        let selectedAnswer = shuffledAnswerOptions[index]
        saveReviewItem(for: currentQuestion, selectedAnswer: selectedAnswer)

        withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) {
            selectedAnswerIndex = index

            if selectedAnswer.isCorrect {
                score += 1
                xp += 10
                streak += 1
                bestStreakThisGame = max(bestStreakThisGame, streak)
                correctAnswersThisGame += 1
                saveCompletedQuestion(question: currentQuestion)
                if isPracticeMistakes {
                    removeCurrentPracticeMistake()
                }
                feedbackMessage = localized("Правилно!", "Correct!")
                feedbackIsCorrect = true
            } else {
                lives = max(lives - 1, 0)
                streak = 0
                wrongAnswersThisGame += 1
                saveMistake(for: currentQuestion)
                feedbackMessage = localized("Грешен отговор", "Wrong Answer")
                feedbackIsCorrect = false
            }
        }
        updateAchievements()

        if lives == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                guard let self else { return }
                if lives == 0 && screen == .quiz { finishGame(with: .gameOver) }
            }
        }
    }

    func goToNextQuestion() {
        guard selectedAnswerIndex != nil else { return }
        if isLastQuestion {
            finishGame(with: .result)
        } else {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            feedbackMessage = nil
            feedbackIsCorrect = nil
            prepareAnswerOptionsForCurrentQuestion()
        }
    }

    func resetProgress() {
        progressStore.reset()

        savedTotalXP = 0
        savedHighestScore = 0
        savedTotalGamesPlayed = 0
        savedBestStreak = 0
        savedCorrectAnswers = 0
        savedWrongAnswers = 0
        savedCurrentDailyStreak = 0
        savedBestDailyStreak = 0
        savedCurrentLoginStreak = 0
        savedBestLoginStreak = 0
        savedLastCategoryID = ""
        savedLastDifficulty = .beginner
        selectedLanguage = .english
        selectedTheme = .system
        selectedDifficulty = .beginner
        lastDailyChallengeDate = ""
        lastDailyRewardDate = ""
        savedLastPlayDate = ""
        mistakeRecords = []
        unlockedAchievementIDs = []
        completedQuestionIDsByCategory = [:]
        availableDailyReward = dailyRewardManager.claimReward(
            lastRewardDate: lastDailyRewardDate,
            currentStreak: savedCurrentLoginStreak,
            bestStreak: savedBestLoginStreak
        )
        recentAchievementID = nil
        returnToStart()
    }

    func claimDailyReward() {
        guard let reward = availableDailyReward else { return }

        lastDailyRewardDate = todayKey
        savedCurrentLoginStreak = reward.currentStreak
        savedBestLoginStreak = reward.bestStreak
        savedTotalXP += reward.totalXP
        availableDailyReward = nil

        progressStore.saveDailyReward(
            date: lastDailyRewardDate,
            currentStreak: savedCurrentLoginStreak,
            bestStreak: savedBestLoginStreak,
            totalXP: savedTotalXP
        )
        updateAchievements()
    }

    func clearRecentAchievement() {
        recentAchievementID = nil
    }

    func localized(_ bg: String, _ en: String) -> String { selectedLanguage.localized(bg, en) }

    func motivationalMessage(for percentage: Int) -> String {
        switch percentage {
        case 90...100: return localized("Отличен run! Вече мислиш като Swift developer.", "Excellent run! You are starting to think like a Swift developer.")
        case 70..<90: return localized("Добра работа! Имаш стабилна основа и си близо до следващото ниво.", "Good job! You have a solid base and you are close to the next level.")
        case 50..<70: return localized("Продължавай да тренираш! Още няколко опита и резултатът ще скочи.", "Keep practicing! A few more tries will push your score higher.")
        default: return localized("Опитай пак. Всяка грешка е XP за следващия опит.", "Try again. Every mistake is XP for the next attempt.")
        }
    }

    func medalText(for percentage: Int) -> MedalResult {
        switch percentage {
        case 90...100: return MedalResult(icon: "🥇", title: localized("Отлично", "Excellent"))
        case 70..<90: return MedalResult(icon: "🥈", title: localized("Добра работа", "Good job"))
        case 50..<70: return MedalResult(icon: "🥉", title: localized("Продължавай да тренираш", "Keep practicing"))
        default: return MedalResult(icon: "🎯", title: localized("Опитай пак", "Try again"))
        }
    }

    private var todayKey: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }

    private func restartQuizState() {
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        xp = 0
        lives = 3
        streak = 0
        bestStreakThisGame = 0
        correctAnswersThisGame = 0
        wrongAnswersThisGame = 0
        feedbackMessage = nil
        feedbackIsCorrect = nil
        reviewItems = []
        hasSavedCurrentGame = false
        dailyBonusAwarded = 0
        prepareAnswerOptionsForCurrentQuestion()
    }

    private func prepareAnswerOptionsForCurrentQuestion() {
        guard let currentQuestion else {
            shuffledAnswerOptions = []
            return
        }
        let answers = currentQuestion.answers(for: selectedLanguage)
        let correctAnswerIndex = currentQuestion.correctAnswerIndex(for: selectedLanguage)
        shuffledAnswerOptions = answers.indices.map { AnswerOption(text: answers[$0], isCorrect: $0 == correctAnswerIndex) }.shuffled()
    }

    private func finishGame(with destination: AppScreen) {
        saveCurrentGameStatsIfNeeded(destination: destination)
        screen = destination
    }

    private func saveCurrentGameStatsIfNeeded(destination: AppScreen) {
        guard !hasSavedCurrentGame else { return }

        if isDailyChallenge {
            lastDailyChallengeDate = todayKey
            dailyBonusAwarded = destination == .result ? dailyBonusXP : 0
            progressStore.saveDailyChallengeDate(lastDailyChallengeDate)
        }

        updateDailyStreak()
        savedTotalXP += xp + dailyBonusAwarded
        savedHighestScore = max(savedHighestScore, score)
        savedTotalGamesPlayed += 1
        savedBestStreak = max(savedBestStreak, bestStreakThisGame)
        savedCorrectAnswers += correctAnswersThisGame
        savedWrongAnswers += wrongAnswersThisGame

        progressStore.saveTotals(
            totalXP: savedTotalXP,
            highestScore: savedHighestScore,
            totalGamesPlayed: savedTotalGamesPlayed,
            bestStreak: savedBestStreak,
            correctAnswers: savedCorrectAnswers,
            wrongAnswers: savedWrongAnswers
        )
        if destination == .result && score == currentQuestions.count {
            unlockedAchievementIDs.insert("perfect-score")
            unlockedAchievementIDs.insert("perfect-quiz-master")
        }
        updateAchievements()
        hasSavedCurrentGame = true
    }

    private func updateDailyStreak() {
        guard savedLastPlayDate != todayKey else { return }
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()).map { date in
            let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
            return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
        }
        savedCurrentDailyStreak = savedLastPlayDate == yesterday ? savedCurrentDailyStreak + 1 : 1
        savedBestDailyStreak = max(savedBestDailyStreak, savedCurrentDailyStreak)
        savedLastPlayDate = todayKey
        progressStore.saveDailyStreak(
            current: savedCurrentDailyStreak,
            best: savedBestDailyStreak,
            lastPlayDate: savedLastPlayDate
        )
    }

    private func saveReviewItem(for question: QuizQuestion, selectedAnswer: AnswerOption) {
        let correctAnswer = shuffledAnswerOptions.first(where: { $0.isCorrect })?.text ?? question.correctAnswerText(for: selectedLanguage)
        let item = QuizReviewItem(
            question: question.questionText(for: selectedLanguage),
            selectedAnswer: selectedAnswer.text,
            correctAnswer: correctAnswer,
            explanation: question.explanationText(for: selectedLanguage),
            isCorrect: selectedAnswer.isCorrect
        )
        reviewItems.append(item)
    }

    private func saveMistake(for question: QuizQuestion) {
        let record = currentMistakeRecord(for: question)
        if !mistakeRecords.contains(where: { $0.id == record.id }) {
            mistakeRecords.append(record)
            progressStore.saveMistakes(mistakeRecords)
        }
    }

    private func saveCompletedQuestion(question: QuizQuestion) {
        guard categories.contains(where: { $0.id == question.categoryId }) else { return }

        var completedIDs = completedQuestionIDsByCategory[question.categoryId] ?? []
        guard completedIDs.insert(question.id).inserted else { return }
        completedQuestionIDsByCategory[question.categoryId] = completedIDs
        progressStore.saveCompletedQuestionsByCategory(completedQuestionIDsByCategory)
    }

    private func removeCurrentPracticeMistake() {
        guard isPracticeMistakes,
              practiceMistakeRecords.indices.contains(currentQuestionIndex) else { return }

        let record = practiceMistakeRecords[currentQuestionIndex]
        mistakeRecords.removeAll { $0.id == record.id }
        progressStore.saveMistakes(mistakeRecords)
    }

    private func currentMistakeRecord(for question: QuizQuestion) -> MistakeRecord {
        if isPracticeMistakes, practiceMistakeRecords.indices.contains(currentQuestionIndex) {
            return practiceMistakeRecords[currentQuestionIndex]
        }

        return MistakeRecord(
            questionID: question.id,
            questionEN: question.questionEN,
            categoryID: selectedCategory?.id ?? "unknown",
            difficultyRawValue: selectedDifficulty.rawValue
        )
    }

    private func findQuestion(for record: MistakeRecord, categoryID: String, difficulty: Difficulty) -> QuizQuestion? {
        let allCategories = categories + [QuizCategory.dailyChallenge]
        let questions = allCategories.first(where: { $0.id == categoryID })?.questionsByDifficulty[difficulty] ?? []

        if let question = questions.first(where: { $0.id == record.questionID }) {
            return question
        }

        return questions.first(where: { $0.questionEN == record.questionEN })
    }

    private func normalizedMistakeRecord(for question: QuizQuestion, categoryID: String, difficulty: Difficulty) -> MistakeRecord {
        MistakeRecord(
            questionID: question.id,
            questionEN: question.questionEN,
            categoryID: categoryID,
            difficultyRawValue: difficulty.rawValue
        )
    }

    private func migrateMistakeRecordsIfNeeded() {
        var normalizedRecords: [MistakeRecord] = []
        var seenIDs: Set<String> = []

        for record in mistakeRecords {
            guard let difficulty = Difficulty(rawValue: record.difficultyRawValue),
                  let question = findQuestion(for: record, categoryID: record.categoryID, difficulty: difficulty) else {
                continue
            }

            let normalizedRecord = normalizedMistakeRecord(for: question, categoryID: record.categoryID, difficulty: difficulty)
            guard seenIDs.insert(normalizedRecord.id).inserted else { continue }
            normalizedRecords.append(normalizedRecord)
        }

        if normalizedRecords != mistakeRecords {
            mistakeRecords = normalizedRecords
            progressStore.saveMistakes(mistakeRecords)
        }
    }

    private func updateAchievements() {
        var unlocked = unlockedAchievementIDs
        if savedTotalGamesPlayed >= 1 { unlocked.insert("first-quiz") }
        if savedTotalXP >= 100 { unlocked.insert("100-xp") }
        if savedTotalXP >= 500 { unlocked.insert("500-xp") }
        if savedTotalXP >= 1000 { unlocked.insert("1000-xp") }
        if savedTotalGamesPlayed >= 10 { unlocked.insert("10-games") }
        if savedCorrectAnswers >= 50 { unlocked.insert("50-correct") }
        if savedBestDailyStreak >= 7 || savedBestLoginStreak >= 7 { unlocked.insert("7-day-streak") }

        let newUnlocks = unlocked.subtracting(unlockedAchievementIDs)
        unlockedAchievementIDs = unlocked
        progressStore.saveAchievements(unlocked)

        if let firstNewUnlock = newUnlocks.sorted().first {
            recentAchievementID = firstNewUnlock
        }
    }

    private func saveLastSelection(categoryID: String, difficulty: Difficulty) {
        savedLastCategoryID = categoryID
        savedLastDifficulty = difficulty
        progressStore.saveLastSelection(categoryID: categoryID, difficulty: difficulty)
    }
}

enum AppScreen {
    case start
    case categories
    case quiz
    case result
    case reviewAnswers
    case gameOver
}
