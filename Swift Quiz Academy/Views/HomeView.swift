//
//  HomeView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct HomeView: View {
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
    let achievements: [Achievement]
    let dailyBonusXP: Int
    let isDailyChallengeAvailable: Bool
    @Binding var selectedLanguage: AppLanguage
    let onStartQuiz: () -> Void
    let onStartDailyChallenge: () -> Void
    let onPracticeMistakes: () -> Bool
    let onResetProgress: () -> Void

    @State private var showsSettings = false
    @State private var showsNoMistakesAlert = false

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 23) {
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
                achievements: achievements,
                selectedLanguage: $selectedLanguage,
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
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }

                Spacer(minLength: 8)
            }

            VStack(spacing: 8) {
                ProgressView(value: xpProgress)
                    .tint(.blue)

                HStack {
                    Text("\(currentLevelXP) XP")
                    Spacer()
                    Text("\(savedTotalXP) XP")
                    Spacer()
                    Text(currentLevel == 10 ? localized("Макс ниво", "Max level") : "\(nextLevelXP) XP")
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
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.blue.opacity(0.14), lineWidth: 1)
        }
        .shadow(color: .blue.opacity(0.10), radius: 14, x: 0, y: 8)
    }

    private var statisticsSection: some View {
        HStack(spacing: 12) {
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
        .shadow(color: .blue.opacity(0.12), radius: 10, x: 0, y: 6)
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
        }
        .padding(20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
        }
        .shadow(color: .orange.opacity(0.12), radius: 14, x: 0, y: 8)
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
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 17)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 5)
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
