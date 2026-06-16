//
//  LibraryModels.swift
//  Swift Quiz Academy
//

import Foundation

struct LibraryCategoryCount: Identifiable, Hashable {
    let id: String
    let title: String
    let count: Int
}

enum LibraryEmptyState: Equatable {
    case none
    case emptyDatabase
    case noFavorites
    case noResults

    func title(for language: AppLanguage) -> String {
        switch self {
        case .none:
            return ""
        case .emptyDatabase:
            return language.localized("Няма налични въпроси", "No questions available")
        case .noFavorites:
            return language.localized("Няма любими въпроси", "No favorite questions")
        case .noResults:
            return language.localized("Няма намерени резултати", "No results found")
        }
    }

    func message(for language: AppLanguage) -> String {
        switch self {
        case .none:
            return ""
        case .emptyDatabase:
            return language.localized("Базата с въпроси е празна или не успя да се зареди.", "The question database is empty or could not be loaded.")
        case .noFavorites:
            return language.localized("Отвори въпрос и го добави в любими, за да го преговаряш по-късно.", "Open a question and add it to favorites so you can review it later.")
        case .noResults:
            return language.localized("Пробвай с друг текст, категория или трудност.", "Try another search, category, or difficulty.")
        }
    }
}
