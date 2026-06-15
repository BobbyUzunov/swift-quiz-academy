//
//  Difficulty.swift
//  Swift Quiz Academy
//

import Foundation

enum Difficulty: String, CaseIterable, Identifiable {
    case beginner
    case intermediate
    case advanced

    var id: String { rawValue }

    var title: String {
        title(for: .english)
    }

    func title(for language: AppLanguage) -> String {
        switch self {
        case .beginner:
            return language.localized("Начинаещ", "Beginner")
        case .intermediate:
            return language.localized("Средно", "Intermediate")
        case .advanced:
            return language.localized("Напреднал", "Advanced")
        }
    }
}
