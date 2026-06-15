//
//  SettingsView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct SettingsView: View {
    let savedTotalXP: Int
    let savedHighestScore: Int
    let savedTotalGamesPlayed: Int
    let savedBestStreak: Int
    let savedCorrectAnswers: Int
    let savedWrongAnswers: Int
    let accuracyPercentage: Int
    let currentLevel: Int
    let currentDailyStreak: Int
    let bestDailyStreak: Int
    let achievements: [Achievement]
    @Binding var selectedLanguage: AppLanguage
    let onResetProgress: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var showsResetConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    settingsSection(title: localized("Език", "Language"), icon: "globe") {
                        Picker(localized("Език", "Language"), selection: $selectedLanguage) {
                            ForEach(AppLanguage.allCases) { language in
                                Text(language.title).tag(language)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    settingsSection(title: localized("Профилни статистики", "Profile Statistics"), icon: "person.crop.circle.fill") {
                        VStack(spacing: 10) {
                            ProfileStatRow(title: localized("Ниво", "Level"), value: "\(currentLevel)")
                            ProfileStatRow(title: localized("Най-добър резултат", "High Score"), value: "\(savedHighestScore)")
                            ProfileStatRow(title: localized("Изиграни игри", "Games Played"), value: "\(savedTotalGamesPlayed)")
                            ProfileStatRow(title: localized("Правилни отговори", "Correct Answers"), value: "\(savedCorrectAnswers)")
                            ProfileStatRow(title: localized("Грешни отговори", "Wrong Answers"), value: "\(savedWrongAnswers)")
                            ProfileStatRow(title: localized("Успеваемост", "Accuracy"), value: "\(accuracyPercentage)%")
                            ProfileStatRow(title: localized("Най-добър Streak", "Best Streak"), value: "\(savedBestStreak)")
                            ProfileStatRow(title: localized("Общо XP", "Total XP"), value: "\(savedTotalXP)")
                        }
                    }

                    settingsSection(title: localized("Достижения", "Achievements"), icon: "trophy.fill") {
                        if achievements.isEmpty {
                            Text(localized("Все още няма достижения.", "No achievements yet."))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(achievements) { achievement in
                                    AchievementView(achievement: achievement, selectedLanguage: selectedLanguage)
                                }
                            }
                        }
                    }

                    settingsSection(title: localized("Дневна поредица", "Daily Streak"), icon: "flame.fill") {
                        VStack(spacing: 10) {
                            ProfileStatRow(title: localized("Текуща поредица", "Current Streak"), value: "\(currentDailyStreak)")
                            ProfileStatRow(title: localized("Най-добра дневна поредица", "Best Daily Streak"), value: "\(bestDailyStreak)")
                        }
                    }

                    settingsSection(title: localized("Прогрес", "Progress"), icon: "arrow.counterclockwise") {
                        Button(role: .destructive) {
                            showsResetConfirmation = true
                        } label: {
                            Label(localized("Нулирай прогреса", "Reset Progress"), systemImage: "trash.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                }
                .padding(20)
            }
            .navigationTitle(localized("Настройки", "Settings"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(localized("Готово", "Done")) {
                        dismiss()
                    }
                }
            }
            .alert(localized("Нулиране на прогреса", "Reset Progress"), isPresented: $showsResetConfirmation) {
                Button(localized("Отказ", "Cancel"), role: .cancel) { }
                Button(localized("Нулирай прогреса", "Reset Progress"), role: .destructive) {
                    onResetProgress()
                }
            } message: {
                Text(localized("Това ще изтрие XP, статистиките, последния избор и достиженията.", "This will delete XP, statistics, last selection, and achievements."))
            }
        }
    }

    private func settingsSection<Content: View>(title: String, icon: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundStyle(.blue)

            content()
        }
        .padding(16)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.blue.opacity(0.12), lineWidth: 1)
        }
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
