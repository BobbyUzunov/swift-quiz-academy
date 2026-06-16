//
//  LibraryViewModel.swift
//  Swift Quiz Academy
//

import Foundation
import Observation

@Observable
final class LibraryViewModel {
    var searchText = ""
    var selectedCategoryID: String?
    var selectedDifficulty: Difficulty?
    var showsFavoritesOnly = false
    private(set) var favoriteQuestionIDs: Set<String>
    private(set) var librarySearchesPerformed: Int

    let categories: [QuizCategory]

    private let progressStore: QuizProgressStore

    init(categories: [QuizCategory], userDefaults: UserDefaults = .standard) {
        self.categories = categories
        progressStore = QuizProgressStore(userDefaults: userDefaults)
        let progress = progressStore.load()
        favoriteQuestionIDs = progress.favoriteQuestionIDs
        librarySearchesPerformed = progress.librarySearchesPerformed
    }

    var allQuestions: [QuizQuestion] {
        categories.flatMap { category in
            Difficulty.allCases.flatMap { difficulty in
                category.questionsByDifficulty[difficulty] ?? []
            }
        }
    }

    var totalQuestionCount: Int {
        allQuestions.count
    }

    var totalFavorites: Int {
        favoriteQuestionIDs.count
    }

    func categoryCounts(for language: AppLanguage) -> [LibraryCategoryCount] {
        categories.map { category in
            LibraryCategoryCount(
                id: category.id,
                title: category.title(for: language),
                count: category.totalQuestionCount
            )
        }
    }

    func updateSearchText(_ newValue: String) {
        let oldQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let newQuery = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        searchText = newValue

        guard oldQuery.isEmpty, !newQuery.isEmpty else { return }
        librarySearchesPerformed += 1
        progressStore.saveLibrarySearchesPerformed(librarySearchesPerformed)
    }

    func filteredQuestions(for language: AppLanguage) -> [QuizQuestion] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedQuery = query.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)

        return allQuestions.filter { question in
            if showsFavoritesOnly && !favoriteQuestionIDs.contains(question.id) {
                return false
            }

            if let selectedCategoryID, question.categoryId != selectedCategoryID {
                return false
            }

            if let selectedDifficulty, question.difficulty != selectedDifficulty {
                return false
            }

            guard !normalizedQuery.isEmpty else { return true }

            return searchableText(for: question)
                .folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
                .contains(normalizedQuery)
        }
    }

    func emptyState(for language: AppLanguage) -> LibraryEmptyState {
        if allQuestions.isEmpty {
            return .emptyDatabase
        }

        if showsFavoritesOnly && favoriteQuestionIDs.isEmpty {
            return .noFavorites
        }

        return filteredQuestions(for: language).isEmpty ? .noResults : .none
    }

    func isFavorite(_ question: QuizQuestion) -> Bool {
        favoriteQuestionIDs.contains(question.id)
    }

    func toggleFavorite(_ question: QuizQuestion) {
        if favoriteQuestionIDs.contains(question.id) {
            favoriteQuestionIDs.remove(question.id)
        } else {
            favoriteQuestionIDs.insert(question.id)
        }

        progressStore.saveFavoriteQuestionIDs(favoriteQuestionIDs)
    }

    func resetLibraryProgress() {
        favoriteQuestionIDs = []
        librarySearchesPerformed = 0
        searchText = ""
        selectedCategoryID = nil
        selectedDifficulty = nil
        showsFavoritesOnly = false
    }

    func categoryTitle(for categoryID: String, language: AppLanguage) -> String {
        categories.first { $0.id == categoryID }?.title(for: language) ?? categoryID
    }

    private func searchableText(for question: QuizQuestion) -> String {
        [
            question.questionBG,
            question.questionEN,
            question.explanationBG,
            question.explanationEN
        ].joined(separator: " ")
    }
}
