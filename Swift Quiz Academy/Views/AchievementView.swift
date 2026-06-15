//
//  AchievementView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct AchievementView: View {
    let achievement: Achievement
    let selectedLanguage: AppLanguage

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: achievement.icon)
                .font(.headline)
                .foregroundStyle(achievement.isUnlocked ? .yellow : .secondary)
                .frame(width: 28, height: 28)
                .background((achievement.isUnlocked ? Color.yellow : Color.secondary).opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(achievement.title(for: selectedLanguage))
                    .font(.subheadline.weight(.bold))
                Text(achievement.description(for: selectedLanguage))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: achievement.isUnlocked ? "checkmark.seal.fill" : "lock.fill")
                .foregroundStyle(achievement.isUnlocked ? .green : .secondary)
        }
    }
}
