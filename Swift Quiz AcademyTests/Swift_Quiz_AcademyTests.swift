//
//  Swift_Quiz_AcademyTests.swift
//  Swift Quiz AcademyTests
//

import Foundation
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
