//
//  HomeView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct HomeView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let savedTotalXP: Int
    let savedHighestScore: Int
    let savedTotalGamesPlayed: Int
    let savedBestStreak: Int
    let savedCorrectAnswers: Int
    let savedWrongAnswers: Int
    let accuracyPercentage: Int
    let currentLevel: Int
    let currentLevelTitle: String
    let currentLevelXP: Int
    let nextLevelXP: Int
    let xpProgress: Double
    let xpToNextLevel: Int
    let totalCategoryCount: Int
    let totalQuestionCount: Int
    let currentDailyStreak: Int
    let bestDailyStreak: Int
    let currentLoginStreak: Int
    let bestLoginStreak: Int
    let totalFavorites: Int
    let librarySearchesPerformed: Int
    let categoryMasteryStats: [CategoryMasteryStat]
    let achievements: [Achievement]
    let recentAchievement: Achievement?
    let dailyBonusXP: Int
    let isDailyChallengeAvailable: Bool
    let availableDailyReward: DailyRewardResult?
    @Binding var selectedLanguage: AppLanguage
    @Binding var selectedTheme: AppTheme
    let onStartQuiz: () -> Void
    let onStartDailyChallenge: () -> Void
    let onPracticeMistakes: () -> Bool
    let onClaimDailyReward: () -> Void
    let onClearRecentAchievement: () -> Void
    let onResetProgress: () -> Void

    @State private var showsSettings = false
    @State private var showsNoMistakesAlert = false
    @State private var showsDailyReward = false
    @State private var isClaimingReward = false
    @State private var startButtonPulse = false
    @State private var confettiActive = false
    @State private var confettiRemovalTask: Task<Void, Never>?

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    heroSection
                    levelProgressCard
                    dailyChallengeCard
                    statisticsSection
                    practiceMistakesButton
                    startButton
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: 693)
                .frame(maxWidth: .infinity)
                .frame(minHeight: proxy.size.height * 0.82, alignment: .center)
                .frame(minHeight: proxy.size.height, alignment: .center)
                .overlay(alignment: .topTrailing) {
                    settingsButton
                        .padding(.top, 10)
                        .padding(.trailing, 16)
                }
                .overlay(alignment: .top) {
                    achievementToast
                        .padding(.top, 18)
                }
            }
        }
        .overlay {
            if showsDailyReward, let availableDailyReward {
                DailyRewardPopup(
                    reward: availableDailyReward,
                    selectedLanguage: selectedLanguage,
                    isClaiming: isClaimingReward,
                    onClaim: claimDailyReward
                )
                .transition(reduceMotion ? .identity : .scale(scale: 0.92).combined(with: .opacity))
            }
        }
        .overlay {
            if confettiActive && !reduceMotion {
                ConfettiBurstView(isActive: confettiActive)
            }
        }
        .sheet(isPresented: $showsSettings) {
            SettingsView(
                savedTotalXP: savedTotalXP,
                savedHighestScore: savedHighestScore,
                savedTotalGamesPlayed: savedTotalGamesPlayed,
                savedBestStreak: savedBestStreak,
                savedCorrectAnswers: savedCorrectAnswers,
                savedWrongAnswers: savedWrongAnswers,
                accuracyPercentage: accuracyPercentage,
                currentLevel: currentLevel,
                currentLevelTitle: currentLevelTitle,
                xpToNextLevel: xpToNextLevel,
                currentDailyStreak: currentDailyStreak,
                bestDailyStreak: bestDailyStreak,
                currentLoginStreak: currentLoginStreak,
                bestLoginStreak: bestLoginStreak,
                totalFavorites: totalFavorites,
                librarySearchesPerformed: librarySearchesPerformed,
                categoryMasteryStats: categoryMasteryStats,
                achievements: achievements,
                selectedLanguage: $selectedLanguage,
                selectedTheme: $selectedTheme,
                onResetProgress: onResetProgress
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .alert(localized("Нямаш грешни въпроси.", "You have no incorrect questions."), isPresented: $showsNoMistakesAlert) {
            Button(localized("OK", "OK"), role: .cancel) { }
        } message: {
            Text(localized("Сгрешените въпроси ще се появят тук след quiz.", "Incorrect questions will appear here after a quiz."))
        }
        .onAppear {
            startButtonPulse = !reduceMotion
            if availableDailyReward != nil {
                showsDailyReward = true
            }
        }
        .onDisappear {
            confettiRemovalTask?.cancel()
            confettiRemovalTask = nil
            confettiActive = false
        }
        .onChange(of: availableDailyReward != nil) { _, hasReward in
            if hasReward {
                showsDailyReward = true
            }
        }
        .onChange(of: recentAchievement?.id) { _, newValue in
            guard newValue != nil else { return }
            triggerConfetti()
        }
    }

    private var settingsButton: some View {
        HStack {
            Spacer()

            Button {
                showsSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.blue)
                    .frame(width: 40, height: 40)
                    .background(.regularMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(localized("Настройки", "Settings"))
            .accessibilityIdentifier("homeSettingsButton")
        }
    }

    private var heroSection: some View {
        VStack(spacing: 13) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 109, height: 109)
                    .shadow(color: .orange.opacity(0.3), radius: 22, x: 0, y: 11)

                Image(systemName: "swift")
                    .font(.system(size: 56, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(spacing: 9) {
                Text(localized("Swift Quiz Academy", "Swift Quiz Academy"))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.82)

                Text(localized("Развивай Swift уменията си с категории, животи, XP и streak.", "Level up your Swift skills with categories, lives, XP and streaks."))
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var levelProgressCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.14))
                        .frame(width: 52, height: 52)

                    Text("\(currentLevel)")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.blue)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(localized("Ниво \(currentLevel)", "Level \(currentLevel)"))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)

                    Text(currentLevelTitle)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 8)
            }

            VStack(spacing: 8) {
                ProgressView(value: xpProgress)
                    .tint(.blue)
                    .animation(reduceMotion ? nil : .spring(response: 0.55, dampingFraction: 0.82), value: xpProgress)
                    .accessibilityLabel(localized("XP прогрес", "XP progress"))
                    .accessibilityValue(currentLevel == 10 ? "\(savedTotalXP) XP" : "\(savedTotalXP) / \(nextLevelXP) XP")

                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(localized("Ниво \(currentLevel)", "Level \(currentLevel)"))
                    Spacer(minLength: 8)
                    Text(currentLevel == 10 ? "\(savedTotalXP) XP" : "\(savedTotalXP) / \(nextLevelXP) XP")
                        .multilineTextAlignment(.trailing)
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            }

            Text(currentLevel == 10 ? localized("Достигна най-високото Swift ниво.", "You reached the highest Swift level.") : localized("\(xpToNextLevel) XP до следващо ниво", "\(xpToNextLevel) XP to next level"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.blue)
        }
        .padding(18)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.blue.opacity(0.14), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.06), radius: 18, x: 0, y: 10)
    }

    private var statisticsSection: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 104), spacing: 12)], spacing: 12) {
            statCard(title: localized("Категории", "Categories"), value: "\(totalCategoryCount)", icon: "square.grid.2x2.fill", color: .blue)
            statCard(title: localized("Въпроси", "Questions"), value: "\(totalQuestionCount)", icon: "questionmark.circle.fill", color: .purple)
            statCard(title: localized("Общо XP", "Total XP"), value: "\(savedTotalXP)", icon: "bolt.fill", color: .orange)
        }
    }

    private var practiceMistakesButton: some View {
        Button {
            if !onPracticeMistakes() {
                showsNoMistakesAlert = true
            }
        } label: {
            Label(localized("Упражнявай грешките", "Practice Mistakes"), systemImage: "exclamationmark.triangle.fill")
                .font(.headline.weight(.bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityIdentifier("practiceMistakesButton")
    }

    private var startButton: some View {
        Button(action: onStartQuiz) {
            Label(localized("Започни quiz", "Start Quiz"), systemImage: "play.fill")
                .font(.title3.weight(.bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .scaleEffect(startButtonPulse ? 1.015 : 1)
        .shadow(color: .blue.opacity(0.18), radius: startButtonPulse ? 18 : 10, x: 0, y: 8)
        .animation(reduceMotion ? nil : .easeInOut(duration: 1.25).repeatForever(autoreverses: true), value: startButtonPulse)
        .accessibilityIdentifier("startQuizButton")
    }

    private var dailyChallengeCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.orange.opacity(0.18))
                        .frame(width: 65, height: 65)

                    Image(systemName: "calendar.badge.clock")
                        .font(.title.weight(.bold))
                        .foregroundStyle(.orange)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(localized("Дневно предизвикателство", "Daily Challenge"))
                        .font(.title3.weight(.bold))

                    Text(isDailyChallengeAvailable ? localized("Специален quiz за днес. Bonus +\(dailyBonusXP) XP.", "Special quiz for today. Bonus +\(dailyBonusXP) XP.") : localized("Днешното предизвикателство е завършено.", "Today's challenge is complete."))
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 8)
            }

            Button(action: onStartDailyChallenge) {
                Label(isDailyChallengeAvailable ? localized("Играй дневния quiz", "Play Daily") : localized("Върни се утре", "Come back tomorrow"), systemImage: isDailyChallengeAvailable ? "sparkles" : "checkmark.seal.fill")
                    .font(.headline.weight(.bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
            }
            .buttonStyle(.borderedProminent)
            .tint(isDailyChallengeAvailable ? .orange : .gray)
            .disabled(!isDailyChallengeAvailable)
            .accessibilityIdentifier("dailyChallengeButton")
        }
        .padding(20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.06), radius: 18, x: 0, y: 10)
    }

    private func statCard(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 17)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.055), radius: 14, x: 0, y: 8)
    }

    @ViewBuilder
    private var achievementToast: some View {
        if let recentAchievement {
            Label(recentAchievement.title(for: selectedLanguage), systemImage: "trophy.fill")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(.regularMaterial)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.12), radius: 14, x: 0, y: 8)
                .transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    private func claimDailyReward() {
        withAnimation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.62)) {
            isClaimingReward = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            onClaimDailyReward()
            withAnimation(reduceMotion ? nil : .spring(response: 0.34, dampingFraction: 0.86)) {
                showsDailyReward = false
                isClaimingReward = false
            }
            triggerConfetti()
        }
    }

    private func triggerConfetti() {
        guard !reduceMotion else {
            confettiActive = false
            confettiRemovalTask?.cancel()
            confettiRemovalTask = nil
            onClearRecentAchievement()
            return
        }

        confettiRemovalTask?.cancel()
        confettiActive = false
        confettiActive = true

        confettiRemovalTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.1))
            guard !Task.isCancelled else { return }
            confettiActive = false
            confettiRemovalTask = nil
            onClearRecentAchievement()
        }
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
