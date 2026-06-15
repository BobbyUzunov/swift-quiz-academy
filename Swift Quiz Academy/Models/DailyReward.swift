//
//  DailyReward.swift
//  Swift Quiz Academy
//

import Foundation

struct DailyRewardResult: Equatable {
    let baseXP: Int
    let streakBonusXP: Int
    let currentStreak: Int
    let bestStreak: Int

    var totalXP: Int { baseXP + streakBonusXP }
    var hasStreakBonus: Bool { streakBonusXP > 0 }
}

struct DailyRewardManager {
    let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    func todayKey(date: Date = Date()) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }

    func yesterdayKey(date: Date = Date()) -> String {
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: date) else {
            return todayKey(date: date)
        }
        return todayKey(date: yesterday)
    }

    func claimReward(
        lastRewardDate: String,
        currentStreak: Int,
        bestStreak: Int,
        date: Date = Date()
    ) -> DailyRewardResult? {
        let today = todayKey(date: date)
        guard lastRewardDate != today else { return nil }

        let nextStreak = lastRewardDate == yesterdayKey(date: date) ? currentStreak + 1 : 1
        let bonusXP = nextStreak % 7 == 0 ? 100 : 0

        return DailyRewardResult(
            baseXP: 25,
            streakBonusXP: bonusXP,
            currentStreak: nextStreak,
            bestStreak: max(bestStreak, nextStreak)
        )
    }
}
