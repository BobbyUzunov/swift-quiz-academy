//
//  LibraryView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct LibraryView: View {
    @Bindable var viewModel: LibraryViewModel
    let selectedLanguage: AppLanguage

    private var filteredQuestions: [QuizQuestion] {
        viewModel.filteredQuestions(for: selectedLanguage)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    summarySection
                    filtersSection
                    favoriteSection
                    categoryCountsSection
                    resultsSection
                }
                .padding(16)
            }
            .navigationTitle(localized("Библиотека", "Library"))
            .searchable(
                text: Binding(
                    get: { viewModel.searchText },
                    set: { viewModel.updateSearchText($0) }
                ),
                prompt: localized("Търси въпроси и обяснения", "Search questions and explanations")
            )
        }
    }

    private var summarySection: some View {
        HStack(spacing: 12) {
            libraryStatCard(
                title: localized("Въпроси", "Questions"),
                value: "\(viewModel.totalQuestionCount)",
                icon: "questionmark.circle.fill",
                color: .blue
            )
            libraryStatCard(
                title: localized("Любими", "Favorites"),
                value: "\(viewModel.totalFavorites)",
                icon: "star.fill",
                color: .yellow
            )
            libraryStatCard(
                title: localized("Търсения", "Searches"),
                value: "\(viewModel.librarySearchesPerformed)",
                icon: "magnifyingglass",
                color: .purple
            )
        }
    }

    private var filtersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(localized("Филтри", "Filters"), systemImage: "line.3.horizontal.decrease.circle.fill")
                .font(.headline)
                .foregroundStyle(.blue)

            HStack(spacing: 10) {
                Menu {
                    Button(localized("Всички категории", "All Categories")) {
                        viewModel.selectedCategoryID = nil
                    }

                    ForEach(viewModel.categories) { category in
                        Button(category.title(for: selectedLanguage)) {
                            viewModel.selectedCategoryID = category.id
                        }
                    }
                } label: {
                    filterLabel(
                        title: selectedCategoryTitle,
                        icon: "square.grid.2x2.fill"
                    )
                }

                Menu {
                    Button(localized("Всички нива", "All Levels")) {
                        viewModel.selectedDifficulty = nil
                    }

                    ForEach(Difficulty.allCases) { difficulty in
                        Button(difficulty.title(for: selectedLanguage)) {
                            viewModel.selectedDifficulty = difficulty
                        }
                    }
                } label: {
                    filterLabel(
                        title: viewModel.selectedDifficulty?.title(for: selectedLanguage) ?? localized("Всички нива", "All Levels"),
                        icon: "slider.horizontal.3"
                    )
                }
            }

            if viewModel.selectedCategoryID != nil || viewModel.selectedDifficulty != nil || !viewModel.searchText.isEmpty {
                Button {
                    viewModel.selectedCategoryID = nil
                    viewModel.selectedDifficulty = nil
                    viewModel.updateSearchText("")
                } label: {
                    Label(localized("Изчисти филтрите", "Clear Filters"), systemImage: "xmark.circle.fill")
                        .font(.subheadline.weight(.semibold))
                }
                .buttonStyle(.bordered)
            }
        }
        .libraryCard()
    }

    private var favoriteSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label(localized("Любими въпроси", "Favorite Questions"), systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.yellow)

                Spacer()

                Text("\(viewModel.totalFavorites)")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Toggle(isOn: $viewModel.showsFavoritesOnly) {
                Text(localized("Покажи само любими", "Show favorites only"))
                    .font(.subheadline.weight(.semibold))
            }
            .toggleStyle(.switch)
        }
        .libraryCard()
    }

    private var categoryCountsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(localized("Категории", "Categories"), systemImage: "folder.fill")
                .font(.headline)
                .foregroundStyle(.blue)

            ForEach(viewModel.categoryCounts(for: selectedLanguage)) { category in
                HStack {
                    Text(category.title)
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text("(\(category.count))")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .libraryCard()
    }

    @ViewBuilder
    private var resultsSection: some View {
        let emptyState = viewModel.emptyState(for: selectedLanguage)

        if emptyState != .none {
            LibraryEmptyStateView(state: emptyState, selectedLanguage: selectedLanguage)
        } else {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label(localized("Резултати", "Results"), systemImage: "list.bullet.rectangle.fill")
                        .font(.headline)
                        .foregroundStyle(.blue)
                    Spacer()
                    Text("\(filteredQuestions.count)")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.secondary)
                }

                LazyVStack(spacing: 10) {
                    ForEach(filteredQuestions) { question in
                        NavigationLink {
                            LibraryQuestionDetailView(
                                question: question,
                                categoryTitle: viewModel.categoryTitle(for: question.categoryId, language: selectedLanguage),
                                selectedLanguage: selectedLanguage,
                                isFavorite: viewModel.isFavorite(question),
                                onToggleFavorite: { viewModel.toggleFavorite(question) }
                            )
                        } label: {
                            LibraryQuestionRow(
                                question: question,
                                categoryTitle: viewModel.categoryTitle(for: question.categoryId, language: selectedLanguage),
                                selectedLanguage: selectedLanguage,
                                isFavorite: viewModel.isFavorite(question)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .libraryCard()
        }
    }

    private var selectedCategoryTitle: String {
        guard let selectedCategoryID = viewModel.selectedCategoryID else {
            return localized("Всички категории", "All Categories")
        }
        return viewModel.categoryTitle(for: selectedCategoryID, language: selectedLanguage)
    }

    private func libraryStatCard(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3.weight(.bold))
                .foregroundStyle(color)
            Text(value)
                .font(.title2.weight(.bold))
                .foregroundStyle(.primary)
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func filterLabel(title: String, icon: String) -> some View {
        Label(title, systemImage: icon)
            .font(.subheadline.weight(.bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}

private struct LibraryQuestionRow: View {
    let question: QuizQuestion
    let categoryTitle: String
    let selectedLanguage: AppLanguage
    let isFavorite: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: isFavorite ? "star.fill" : "doc.text.fill")
                .font(.title3.weight(.bold))
                .foregroundStyle(isFavorite ? .yellow : .blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 6) {
                Text(question.questionText(for: selectedLanguage))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {
                    Text(categoryTitle)
                    Text(question.difficulty.title(for: selectedLanguage))
                }
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color(.secondarySystemBackground).opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct LibraryQuestionDetailView: View {
    let question: QuizQuestion
    let categoryTitle: String
    let selectedLanguage: AppLanguage
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Text(categoryTitle)
                        Text(question.difficulty.title(for: selectedLanguage))
                    }
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                    Text(question.questionText(for: selectedLanguage))
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .libraryCard()

                VStack(alignment: .leading, spacing: 12) {
                    Label(localized("Отговори", "Answers"), systemImage: "checklist")
                        .font(.headline)
                        .foregroundStyle(.blue)

                    ForEach(question.answers(for: selectedLanguage), id: \.self) { answer in
                        HStack(spacing: 10) {
                            Image(systemName: answer == question.correctAnswerText(for: selectedLanguage) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(answer == question.correctAnswerText(for: selectedLanguage) ? .green : .secondary)
                            Text(answer)
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                        }
                        .padding(10)
                        .background(answer == question.correctAnswerText(for: selectedLanguage) ? Color.green.opacity(0.12) : Color(.secondarySystemBackground).opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                }
                .libraryCard()

                VStack(alignment: .leading, spacing: 10) {
                    Label(localized("Обяснение", "Explanation"), systemImage: "lightbulb.fill")
                        .font(.headline)
                        .foregroundStyle(.orange)

                    Text(question.explanationText(for: selectedLanguage))
                        .font(.body)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .libraryCard()
            }
            .padding(16)
        }
        .navigationTitle(localized("Детайли", "Details"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onToggleFavorite) {
                    Label(
                        isFavorite ? localized("Премахни любимо", "Remove Favorite") : localized("Любимо", "Favorite"),
                        systemImage: isFavorite ? "star.slash.fill" : "star.fill"
                    )
                }
            }
        }
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}

private struct LibraryEmptyStateView: View {
    let state: LibraryEmptyState
    let selectedLanguage: AppLanguage

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray.fill")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.secondary)

            Text(state.title(for: selectedLanguage))
                .font(.headline.weight(.bold))

            Text(state.message(for: selectedLanguage))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .libraryCard()
    }
}

private extension View {
    func libraryCard() -> some View {
        padding(16)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.blue.opacity(0.12), lineWidth: 1)
            }
    }
}
