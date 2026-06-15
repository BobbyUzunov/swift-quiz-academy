//
//  GameOverView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    let xp: Int
    let selectedLanguage: AppLanguage
    let onRetry: () -> Void
    let onHome: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 70, weight: .bold))
                .foregroundStyle(.red)

            VStack(spacing: 10) {
                Text(localized("Край на играта", "Game Over"))
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(localized("Животите свършиха, но XP-то и практиката остават.", "You ran out of lives, but the XP and practice still count."))
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 14) {
                resultRow(title: localized("Правилни отговори", "Correct Answers"), value: "\(score)")
                resultRow(title: "XP", value: "\(xp) XP")
            }
            .padding(20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            VStack(spacing: 12) {
                Button(action: onRetry) {
                    Text(localized("Опитай пак", "Try Again"))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

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
        .frame(maxWidth: 520)
    }

    private func resultRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
        .font(.headline)
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
