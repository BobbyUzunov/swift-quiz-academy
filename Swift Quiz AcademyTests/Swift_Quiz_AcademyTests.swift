//
//  Swift_Quiz_AcademyTests.swift
//  Swift Quiz AcademyTests
//

import Foundation
import SwiftUI
import Testing
@testable import Swift_Quiz_Academy

@MainActor
struct Swift_Quiz_AcademyTests {

    @Test func correctAnswerAwardsXPAndAdvancesCleanly() {
        let viewModel = makeViewModel()

        viewModel.startQuiz(with: viewModel.categories[0])
        answerCurrentQuestion(in: viewModel, correctly: true)

        #expect(viewModel.score == 1)
        #expect(viewModel.xp == 10)
        #expect(viewModel.streak == 1)
        #expect(viewModel.lives == 3)
        #expect(viewModel.reviewItems.count == 1)

        viewModel.goToNextQuestion()

        #expect(viewModel.currentQuestionIndex == 1)
        #expect(viewModel.selectedAnswerIndex == nil)
        #expect(viewModel.feedbackMessage == nil)
    }

    @Test func wrongAnswerCostsLifeAndCanBePracticedAway() {
        let viewModel = makeViewModel()

        viewModel.startQuiz(with: viewModel.categories[0])
        answerCurrentQuestion(in: viewModel, correctly: false)

        #expect(viewModel.lives == 2)
        #expect(viewModel.streak == 0)
        #expect(viewModel.hasMistakes)
        #expect(viewModel.mistakeRecords.count == 1)

        let startedPractice = viewModel.startPracticeMistakes()
        #expect(startedPractice)
        #expect(viewModel.selectedCategory?.id == "practice-mistakes")
        #expect(viewModel.currentQuestions.count == 1)

        answerCurrentQuestion(in: viewModel, correctly: true)

        #expect(!viewModel.hasMistakes)
    }

    @Test func dailyChallengeSavesBonusOnlyOncePerDay() {
        let viewModel = makeViewModel()

        viewModel.startDailyChallenge()
        let totalQuestions = viewModel.currentQuestions.count

        for _ in 0..<totalQuestions {
            answerCurrentQuestion(in: viewModel, correctly: true)
            viewModel.goToNextQuestion()
        }

        #expect(viewModel.screen == .result)
        #expect(viewModel.score == totalQuestions)
        #expect(viewModel.dailyBonusAwarded == viewModel.dailyBonusXP)
        #expect(viewModel.savedTotalXP == totalQuestions * 10 + viewModel.dailyBonusXP)
        #expect(viewModel.savedTotalGamesPlayed == 1)
        #expect(!viewModel.isDailyChallengeAvailable)

        viewModel.returnToStart()
        viewModel.startDailyChallenge()

        #expect(viewModel.screen == .start)
        #expect(viewModel.savedTotalGamesPlayed == 1)
    }

    @Test func resetProgressClearsSavedStateAndReturnsHome() {
        let viewModel = makeViewModel()

        viewModel.startQuiz(with: viewModel.categories[0])
        answerCurrentQuestion(in: viewModel, correctly: true)
        viewModel.goToNextQuestion()
        viewModel.resetProgress()

        #expect(viewModel.screen == .start)
        #expect(viewModel.savedTotalXP == 0)
        #expect(viewModel.savedHighestScore == 0)
        #expect(viewModel.savedTotalGamesPlayed == 0)
        #expect(viewModel.savedCorrectAnswers == 0)
        #expect(viewModel.savedWrongAnswers == 0)
        #expect(viewModel.mistakeRecords.isEmpty)
        #expect(viewModel.unlockedAchievementIDs.isEmpty)
        #expect(viewModel.selectedLanguage == .english)
        #expect(viewModel.selectedDifficulty == .beginner)
    }

    @Test func savedProgressReloadsFromStore() {
        let userDefaults = makeUserDefaults()
        let viewModel = QuizViewModel(userDefaults: userDefaults)

        viewModel.startQuiz(with: viewModel.categories[0])
        let totalQuestions = viewModel.currentQuestions.count

        for _ in 0..<totalQuestions {
            answerCurrentQuestion(in: viewModel, correctly: true)
            viewModel.goToNextQuestion()
        }

        let reloadedViewModel = QuizViewModel(userDefaults: userDefaults)

        #expect(reloadedViewModel.savedTotalXP == totalQuestions * 10)
        #expect(reloadedViewModel.savedHighestScore == totalQuestions)
        #expect(reloadedViewModel.savedTotalGamesPlayed == 1)
        #expect(reloadedViewModel.savedCorrectAnswers == totalQuestions)
        #expect(reloadedViewModel.savedLastCategoryID == viewModel.categories[0].id)
        #expect(reloadedViewModel.unlockedAchievementIDs.contains("perfect-score"))
    }

    @Test func questionTotalsComeFromCategoryData() {
        let viewModel = makeViewModel()

        #expect(viewModel.totalCategoryCount == viewModel.categories.count)
        #expect(viewModel.totalQuestionCount == viewModel.categories.reduce(0) { $0 + $1.totalQuestionCount })
        #expect(viewModel.totalQuestionCount == 150)
    }

    @Test func jsonQuestionLoaderLoadsLocalDatabase() {
        let loader = QuestionLoader()
        let questions = loader.loadAllQuestions()

        #expect(questions.count == 150)
        #expect(Set(questions.map(\.categoryId)).count == 5)
        #expect(questions.allSatisfy { !$0.id.isEmpty })
        #expect(questions.allSatisfy { $0.answersBG.contains($0.correctAnswerBG) })
        #expect(questions.allSatisfy { $0.answersEN.contains($0.correctAnswerEN) })
    }

    @Test func jsonQuestionsDecodeExpectedShape() throws {
        let data = """
        [
          {
            "id": "sample-beginner-01",
            "categoryId": "swift-basics",
            "difficulty": "beginner",
            "questionBG": "Коя ключова дума създава константа?",
            "questionEN": "Which keyword creates a constant?",
            "answersBG": ["var", "let", "func", "class"],
            "answersEN": ["var", "let", "func", "class"],
            "correctAnswerBG": "let",
            "correctAnswerEN": "let",
            "explanationBG": "let създава константа.",
            "explanationEN": "let creates a constant."
          }
        ]
        """.data(using: .utf8)!

        let questions = try JSONDecoder().decode([QuizQuestion].self, from: data)

        #expect(questions.count == 1)
        #expect(questions[0].id == "sample-beginner-01")
        #expect(questions[0].difficulty == .beginner)
        #expect(questions[0].correctAnswerIndex(for: .english) == 1)
        #expect(questions[0].explanationText(for: .bulgarian) == "let създава константа.")
    }

    @Test func questionLoaderGroupsByCategoryAndDifficulty() {
        let loader = QuestionLoader()
        let grouped = QuestionLoader.groupByCategoryAndDifficulty(loader.loadAllQuestions())

        #expect(grouped.keys.count == 5)

        for definition in QuestionLoader.categoryDefinitions {
            let categoryGroup = grouped[definition.id] ?? [:]

            #expect((categoryGroup[.beginner] ?? []).count >= 5)
            #expect((categoryGroup[.intermediate] ?? []).count >= 5)
            #expect((categoryGroup[.advanced] ?? []).count >= 5)
            #expect(categoryGroup.values.reduce(0) { $0 + $1.count } >= 20)
        }
    }

    @Test func categoryQuestionsFilterByDifficultyFromJSON() {
        let categories = QuestionLoader().loadCategories()

        #expect(categories.count == 5)

        for category in categories {
            #expect(category.questionCount(for: .beginner) == 10)
            #expect(category.questionCount(for: .intermediate) == 10)
            #expect(category.questionCount(for: .advanced) == 10)
        }
    }

    @Test func levelSystemUsesVersionOnePointOneProgression() {
        let levelCases: [(xp: Int, level: Int, currentXP: Int, nextXP: Int, toNext: Int)] = [
            (0, 1, 0, 100, 100),
            (100, 2, 100, 250, 150),
            (249, 2, 100, 250, 1),
            (250, 3, 250, 500, 250),
            (500, 4, 500, 1000, 500),
            (1000, 5, 1000, 1500, 500),
            (1500, 6, 1500, 2500, 1000),
            (2500, 7, 2500, 4000, 1500),
            (4000, 8, 4000, 6000, 2000),
            (6000, 9, 6000, 10000, 4000),
            (10000, 10, 10000, 10000, 0),
            (12000, 10, 10000, 10000, 0)
        ]

        for levelCase in levelCases {
            let viewModel = makeViewModel(totalXP: levelCase.xp)

            #expect(viewModel.currentLevel == levelCase.level)
            #expect(viewModel.currentLevelXP == levelCase.currentXP)
            #expect(viewModel.nextLevelXP == levelCase.nextXP)
            #expect(viewModel.xpToNextLevel == levelCase.toNext)
        }
    }

    @Test func levelProgressAndTitlesAreLocalized() {
        let viewModel = makeViewModel(totalXP: 125)

        #expect(viewModel.currentLevel == 2)
        #expect(viewModel.currentLevelTitle == "Swift Learner")
        #expect(abs(viewModel.xpProgress - (25.0 / 150.0)) < 0.0001)

        viewModel.selectedLanguage = .bulgarian

        #expect(viewModel.currentLevelTitle == "Swift учащ")
    }

    @Test func dailyRewardCanBeClaimedOnlyOnceAndPersists() {
        let userDefaults = makeUserDefaults()
        let viewModel = QuizViewModel(userDefaults: userDefaults)

        #expect(viewModel.availableDailyReward?.totalXP == viewModel.dailyRewardXP)

        viewModel.claimDailyReward()

        #expect(viewModel.savedTotalXP == viewModel.dailyRewardXP)
        #expect(viewModel.savedCurrentLoginStreak == 1)
        #expect(viewModel.savedBestLoginStreak == 1)
        #expect(viewModel.availableDailyReward == nil)

        let reloadedViewModel = QuizViewModel(userDefaults: userDefaults)

        #expect(reloadedViewModel.savedTotalXP == viewModel.dailyRewardXP)
        #expect(reloadedViewModel.availableDailyReward == nil)
    }

    @Test func dailyRewardManagerAwardsSevenDayBonus() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let manager = DailyRewardManager(calendar: calendar)
        let day = Date(timeIntervalSince1970: 24 * 60 * 60 * 10)
        let yesterday = manager.yesterdayKey(date: day)

        let reward = manager.claimReward(
            lastRewardDate: yesterday,
            currentStreak: 6,
            bestStreak: 6,
            date: day
        )

        #expect(reward?.baseXP == 25)
        #expect(reward?.streakBonusXP == 100)
        #expect(reward?.totalXP == 125)
        #expect(reward?.currentStreak == 7)
        #expect(reward?.bestStreak == 7)
    }

    @Test func themePreferencePersists() {
        let userDefaults = makeUserDefaults()
        let viewModel = QuizViewModel(userDefaults: userDefaults)

        viewModel.selectedTheme = .dark

        let reloadedViewModel = QuizViewModel(userDefaults: userDefaults)

        #expect(reloadedViewModel.selectedTheme == .dark)
        #expect(reloadedViewModel.selectedTheme.colorScheme == .dark)
    }

    @Test func newAchievementsUnlockAutomatically() {
        let userDefaults = makeUserDefaults()
        let store = QuizProgressStore(userDefaults: userDefaults)
        store.saveTotals(
            totalXP: 1000,
            highestScore: 10,
            totalGamesPlayed: 10,
            bestStreak: 0,
            correctAnswers: 50,
            wrongAnswers: 0
        )
        store.saveDailyReward(date: "2026-6-14", currentStreak: 7, bestStreak: 7, totalXP: 1000)

        let viewModel = QuizViewModel(userDefaults: userDefaults)

        #expect(viewModel.unlockedAchievementIDs.contains("7-day-streak"))
        #expect(viewModel.unlockedAchievementIDs.contains("500-xp"))
        #expect(viewModel.unlockedAchievementIDs.contains("1000-xp"))
        #expect(viewModel.unlockedAchievementIDs.contains("10-games"))
        #expect(viewModel.unlockedAchievementIDs.contains("50-correct"))
        #expect(viewModel.unlockedAchievementIDs.contains("perfect-quiz-master"))
    }

    @Test func bulgarianQuestionsAreLocalized() {
        let allCategories = QuizCategory.allCategories + [QuizCategory.dailyChallenge]
        let allQuestions = allCategories.flatMap { category in
            category.questionsByDifficulty.values.flatMap { $0 }
        }

        #expect(allQuestions.count == 160)

        for question in allQuestions {
            #expect(question.questionText(for: .bulgarian) != question.questionText(for: .english))
            #expect(!question.questionText(for: .bulgarian).hasPrefix("Въпрос:"))
        }
    }

    private func makeViewModel() -> QuizViewModel {
        QuizViewModel(userDefaults: makeUserDefaults())
    }

    private func makeViewModel(totalXP: Int) -> QuizViewModel {
        let userDefaults = makeUserDefaults()
        let store = QuizProgressStore(userDefaults: userDefaults)
        store.saveTotals(
            totalXP: totalXP,
            highestScore: 0,
            totalGamesPlayed: 0,
            bestStreak: 0,
            correctAnswers: 0,
            wrongAnswers: 0
        )
        return QuizViewModel(userDefaults: userDefaults)
    }

    private func makeUserDefaults() -> UserDefaults {
        let suiteName = "SwiftQuizAcademyTests-\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)
        return userDefaults
    }

    private func answerCurrentQuestion(in viewModel: QuizViewModel, correctly: Bool) {
        let index = viewModel.shuffledAnswerOptions.firstIndex { $0.isCorrect == correctly }!
        viewModel.selectAnswer(index)
    }
}
