//
//  CelebrationViews.swift
//  Swift Quiz Academy
//

import SwiftUI

struct DailyRewardPopup: View {
    let reward: DailyRewardResult
    let selectedLanguage: AppLanguage
    let isClaiming: Bool
    let onClaim: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.32)
                .ignoresSafeArea()

            VStack(spacing: 18) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 86, height: 86)
                        .shadow(color: .orange.opacity(0.28), radius: 20, x: 0, y: 10)

                    Image(systemName: "gift.fill")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.white)
                }
                .scaleEffect(isClaiming ? 1.16 : 1)
                .rotationEffect(.degrees(isClaiming ? 7 : 0))

                VStack(spacing: 8) {
                    Text(selectedLanguage.localized("Дневна награда", "Daily Reward"))
                        .font(.title2.weight(.bold))

                    Text(selectedLanguage.localized("+\(reward.baseXP) XP за днес", "+\(reward.baseXP) XP for today"))
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    if reward.hasStreakBonus {
                        Label(selectedLanguage.localized("7 дневен бонус +\(reward.streakBonusXP) XP", "7 day bonus +\(reward.streakBonusXP) XP"), systemImage: "flame.fill")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.orange)
                    }

                    Text(selectedLanguage.localized("Поредица: \(reward.currentStreak) дни", "Streak: \(reward.currentStreak) days"))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.blue)
                }

                Button(action: onClaim) {
                    Label(selectedLanguage.localized("Вземи наградата", "Claim Reward"), systemImage: "sparkles")
                        .font(.headline.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .scaleEffect(isClaiming ? 1.05 : 1)
            }
            .padding(22)
            .frame(maxWidth: 360)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.orange.opacity(0.22), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.18), radius: 28, x: 0, y: 16)
            .padding(.horizontal, 22)
        }
    }
}

struct ConfettiBurstView: View {
    let isActive: Bool

    private let colors: [Color] = [.blue, .orange, .green, .pink, .yellow, .purple]

    var body: some View {
        ZStack {
            ForEach(0..<18, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(colors[index % colors.count])
                    .frame(width: 8, height: 12)
                    .rotationEffect(.degrees(isActive ? Double(index * 23) : 0))
                    .offset(
                        x: isActive ? CGFloat((index % 6) - 3) * 38 : 0,
                        y: isActive ? CGFloat((index / 6) + 1) * 44 : 0
                    )
                    .opacity(isActive ? 0 : 1)
            }
        }
        .allowsHitTesting(false)
        .animation(.easeOut(duration: 1.0), value: isActive)
    }
}
