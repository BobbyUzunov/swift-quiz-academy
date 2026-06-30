//
//  ReusableComponents.swift
//  Swift Quiz Academy
//

import SwiftUI

struct SwiftQuizAcademyRootView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var viewModel = QuizViewModel()
    @State private var libraryViewModel = LibraryViewModel(categories: QuizCategory.allCategories)

    var body: some View {
        ZStack {
            backgroundView

            switch viewModel.screen {
            case .start:
                mainTabs
            case .categories:
                CategorySelectionView(
                    categories: viewModel.categories,
                    selectedLanguage: viewModel.selectedLanguage,
                    selectedDifficulty: Binding(
                        get: { viewModel.selectedDifficulty },
                        set: { viewModel.selectedDifficulty = $0 }
                    ),
                    onBack: viewModel.returnToStart,
                    onSelectCategory: viewModel.startQuiz
                )
            case .quiz:
                if let selectedCategory = viewModel.selectedCategory, let currentQuestion = viewModel.currentQuestion {
                    QuizView(
                        category: selectedCategory,
                        selectedDifficulty: viewModel.selectedDifficulty,
                        selectedLanguage: viewModel.selectedLanguage,
                        currentQuestion: currentQuestion,
                        answerOptions: viewModel.shuffledAnswerOptions,
                        currentQuestionIndex: viewModel.currentQuestionIndex,
                        totalQuestions: viewModel.currentQuestions.count,
                        progressValue: viewModel.progressValue,
                        xp: viewModel.xp,
                        streak: viewModel.streak,
                        lives: viewModel.lives,
                        selectedAnswerIndex: viewModel.selectedAnswerIndex,
                        feedbackMessage: viewModel.feedbackMessage,
                        feedbackIsCorrect: viewModel.feedbackIsCorrect,
                        isLastQuestion: viewModel.isLastQuestion,
                        onBack: viewModel.returnToStart,
                        onSelectAnswer: viewModel.selectAnswer,
                        onNextQuestion: viewModel.goToNextQuestion
                    )
                } else {
                    homeView
                }
            case .result:
                ResultView(
                    medal: viewModel.medalText(for: viewModel.resultPercentage),
                    score: viewModel.score,
                    totalQuestions: viewModel.currentQuestions.count,
                    percentage: viewModel.resultPercentage,
                    xp: viewModel.xp,
                    dailyBonusAwarded: viewModel.dailyBonusAwarded,
                    streak: viewModel.streak,
                    motivationalMessage: viewModel.motivationalMessage(for: viewModel.resultPercentage),
                    selectedLanguage: viewModel.selectedLanguage,
                    onReview: viewModel.showReviewAnswers,
                    onRestart: viewModel.restartCurrentQuiz,
                    onHome: viewModel.returnToStart
                )
            case .reviewAnswers:
                ReviewAnswersView(
                    items: viewModel.reviewItems,
                    selectedLanguage: viewModel.selectedLanguage,
                    onBackToResults: viewModel.returnToResults,
                    onHome: viewModel.returnToStart
                )
            case .gameOver:
                GameOverView(
                    score: viewModel.score,
                    xp: viewModel.xp,
                    selectedLanguage: viewModel.selectedLanguage,
                    onRetry: viewModel.restartCurrentQuiz,
                    onHome: viewModel.returnToStart
                )
            }
        }
        .animation(reduceMotion ? nil : .easeInOut(duration: 0.25), value: viewModel.screen)
        .animation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.82), value: viewModel.selectedAnswerIndex)
        .animation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.82), value: viewModel.lives)
        .animation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.82), value: viewModel.streak)
        .preferredColorScheme(viewModel.selectedTheme.colorScheme)
    }

    private var mainTabs: some View {
        TabView {
            homeView
                .accessibilityIdentifier("homeTab")
                .tabItem {
                    Label(viewModel.localized("Начало", "Home"), systemImage: "house.fill")
                }

            LibraryView(
                viewModel: libraryViewModel,
                selectedLanguage: viewModel.selectedLanguage
            )
            .accessibilityIdentifier("libraryTab")
            .tabItem {
                Label(viewModel.localized("Библиотека", "Library"), systemImage: "books.vertical.fill")
            }

            settingsView(showsDoneButton: false)
                .accessibilityIdentifier("settingsTab")
                .tabItem {
                    Label(viewModel.localized("Настройки", "Settings"), systemImage: "gearshape.fill")
                }
        }
    }

    private var homeView: some View {
        HomeView(
            savedTotalXP: viewModel.savedTotalXP,
            savedHighestScore: viewModel.savedHighestScore,
            savedTotalGamesPlayed: viewModel.savedTotalGamesPlayed,
            savedBestStreak: viewModel.savedBestStreak,
            savedCorrectAnswers: viewModel.savedCorrectAnswers,
            savedWrongAnswers: viewModel.savedWrongAnswers,
            accuracyPercentage: viewModel.accuracyPercentage,
            currentLevel: viewModel.currentLevel,
            currentLevelTitle: viewModel.currentLevelTitle,
            currentLevelXP: viewModel.currentLevelXP,
            nextLevelXP: viewModel.nextLevelXP,
            xpProgress: viewModel.xpProgress,
            xpToNextLevel: viewModel.xpToNextLevel,
            totalCategoryCount: viewModel.totalCategoryCount,
            totalQuestionCount: viewModel.totalQuestionCount,
            currentDailyStreak: viewModel.savedCurrentDailyStreak,
            bestDailyStreak: viewModel.savedBestDailyStreak,
            currentLoginStreak: viewModel.savedCurrentLoginStreak,
            bestLoginStreak: viewModel.savedBestLoginStreak,
            totalFavorites: libraryViewModel.totalFavorites,
            librarySearchesPerformed: libraryViewModel.librarySearchesPerformed,
            categoryMasteryStats: viewModel.categoryMasteryStats,
            achievements: viewModel.achievements,
            recentAchievement: viewModel.recentAchievement,
            dailyBonusXP: viewModel.dailyBonusXP,
            isDailyChallengeAvailable: viewModel.isDailyChallengeAvailable,
            availableDailyReward: viewModel.availableDailyReward,
            selectedLanguage: Binding(
                get: { viewModel.selectedLanguage },
                set: { viewModel.selectedLanguage = $0 }
            ),
            selectedTheme: Binding(
                get: { viewModel.selectedTheme },
                set: { viewModel.selectedTheme = $0 }
            ),
            onStartQuiz: viewModel.showCategories,
            onStartDailyChallenge: viewModel.startDailyChallenge,
            onPracticeMistakes: viewModel.startPracticeMistakes,
            onClaimDailyReward: viewModel.claimDailyReward,
            onClearRecentAchievement: viewModel.clearRecentAchievement,
            onResetProgress: resetProgress
        )
    }

    private func settingsView(showsDoneButton: Bool) -> some View {
        SettingsView(
            savedTotalXP: viewModel.savedTotalXP,
            savedHighestScore: viewModel.savedHighestScore,
            savedTotalGamesPlayed: viewModel.savedTotalGamesPlayed,
            savedBestStreak: viewModel.savedBestStreak,
            savedCorrectAnswers: viewModel.savedCorrectAnswers,
            savedWrongAnswers: viewModel.savedWrongAnswers,
            accuracyPercentage: viewModel.accuracyPercentage,
            currentLevel: viewModel.currentLevel,
            currentLevelTitle: viewModel.currentLevelTitle,
            xpToNextLevel: viewModel.xpToNextLevel,
            currentDailyStreak: viewModel.savedCurrentDailyStreak,
            bestDailyStreak: viewModel.savedBestDailyStreak,
            currentLoginStreak: viewModel.savedCurrentLoginStreak,
            bestLoginStreak: viewModel.savedBestLoginStreak,
            totalFavorites: libraryViewModel.totalFavorites,
            librarySearchesPerformed: libraryViewModel.librarySearchesPerformed,
            categoryMasteryStats: viewModel.categoryMasteryStats,
            achievements: viewModel.achievements,
            selectedLanguage: Binding(
                get: { viewModel.selectedLanguage },
                set: { viewModel.selectedLanguage = $0 }
            ),
            selectedTheme: Binding(
                get: { viewModel.selectedTheme },
                set: { viewModel.selectedTheme = $0 }
            ),
            onResetProgress: resetProgress,
            showsDoneButton: showsDoneButton
        )
    }

    private func resetProgress() {
        viewModel.resetProgress()
        libraryViewModel.resetLibraryProgress()
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color.indigo.opacity(0.35),
                Color.blue.opacity(0.24),
                Color.purple.opacity(0.16),
                Color(.systemBackground).opacity(0.92)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct ProfileStatRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(title)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 8)
            Text(value)
                .fontWeight(.bold)
                .multilineTextAlignment(.trailing)
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
        }
        .font(.subheadline)
    }
}

struct CategoryCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.24, dampingFraction: 0.72), value: configuration.isPressed)
    }
}
