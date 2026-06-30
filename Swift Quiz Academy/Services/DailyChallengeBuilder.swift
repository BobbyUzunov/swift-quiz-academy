//
//  DailyChallengeBuilder.swift
//  Swift Quiz Academy
//

import Foundation

enum DailyChallengeBuilder {
    static let bonusQuestionCount = 2

    static func build(from categories: [QuizCategory], on date: Date = Date()) -> [QuizQuestion] {
        let seed = daySeed(for: date)
        var generator = SeededRandomNumberGenerator(seed: seed)

        var selectedQuestions: [QuizQuestion] = []
        var usedQuestionIDs = Set<String>()
        let difficulties = Difficulty.allCases

        for (categoryIndex, category) in categories.enumerated() {
            let difficulty = difficulties[(Int(seed) + categoryIndex) % difficulties.count]
            guard let pool = category.questionsByDifficulty[difficulty], !pool.isEmpty else { continue }

            let startIndex = Int((seed >> UInt64(categoryIndex + 1)) % UInt64(pool.count))
            let question = pool[startIndex]
            guard usedQuestionIDs.insert(question.id).inserted else { continue }
            selectedQuestions.append(question)
        }

        let bonusPool = categories
            .flatMap { category in
                Difficulty.allCases.flatMap { difficulty in
                    category.questionsByDifficulty[difficulty] ?? []
                }
            }
            .filter { !usedQuestionIDs.contains($0.id) }
            .shuffled(using: &generator)

        for question in bonusPool.prefix(bonusQuestionCount) {
            guard usedQuestionIDs.insert(question.id).inserted else { continue }
            selectedQuestions.append(question)
        }

        return selectedQuestions
    }

    static func daySeed(for date: Date) -> UInt64 {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = UInt64(components.year ?? 0)
        let month = UInt64(components.month ?? 0)
        let day = UInt64(components.day ?? 0)
        return year * 10_000 + month * 100 + day
    }
}

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed == 0 ? 0x4D5955494E495456 : seed
    }

    mutating func next() -> UInt64 {
        state ^= state >> 12
        state ^= state << 25
        state ^= state >> 27
        return state &* 2_685_821_657_736_338_191
    }
}
