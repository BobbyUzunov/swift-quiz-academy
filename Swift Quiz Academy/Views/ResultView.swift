//
//  ResultView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct ResultView: View {
    let medal: MedalResult
    let score: Int
    let totalQuestions: Int
    let percentage: Int
    let xp: Int
    let dailyBonusAwarded: Int
    let streak: Int
    let motivationalMessage: String
    let selectedLanguage: AppLanguage
    let onReview: () -> Void
    let onRestart: () -> Void
    let onHome: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(medal.icon)
                    .font(.system(size: 86))

                VStack(spacing: 8) {
                    Text(medal.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(localized("Swift Quiz Academy", "Swift Quiz Academy"))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 16) {
                    resultRow(title: localized("Правилни отговори", "Correct Answers"), value: "\(score) / \(totalQuestions)")
                    resultRow(title: localized("Процент", "Percentage"), value: "\(percentage)%")
                    resultRow(title: "XP", value: "\(xp) XP")
                    if dailyBonusAwarded > 0 {
                        resultRow(title: localized("Дневен бонус", "Daily Bonus"), value: "+\(dailyBonusAwarded) XP")
                    }
                    resultRow(title: localized("Най-добра поредица", "Best Streak"), value: "\(streak)")
                }
                .padding(20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)

                Text(motivationalMessage)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    Button(action: onReview) {
                        Text(localized("Прегледай отговорите", "Review Answers"))
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)

                    Button(action: onRestart) {
                        Text(localized("Започни отново", "Restart"))
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)

                    Button(action: onHome) {
                        Text(localized("Към началото", "Home"))
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
            }
            .padding(24)
            .frame(maxWidth: 540)
            .frame(maxWidth: .infinity)
        }
    }

    private func resultRow(title: String, value: String) -> some View {
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
        .font(.headline)
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}

struct MedalResult {
    let icon: String
    let title: String
}
