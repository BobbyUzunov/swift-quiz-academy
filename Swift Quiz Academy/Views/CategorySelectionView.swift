//
//  CategorySelectionView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct CategorySelectionView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let categories: [QuizCategory]
    let selectedLanguage: AppLanguage
    @Binding var selectedDifficulty: Difficulty
    let onBack: () -> Void
    let onSelectCategory: (QuizCategory) -> Void

    @State private var selectedCategoryID: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                HStack {
                    Button(action: onBack) {
                        Label(localized("Назад", "Back"), systemImage: "chevron.left")
                            .font(.headline)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.blue)

                    Spacer()
                }

                VStack(spacing: 10) {
                    Text(localized("Избери предизвикателство", "Choose Your Challenge"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(localized("Избери категория и трудност. Всяка категория има 60+ въпроса.", "Choose a category and difficulty. Each category has 60+ questions."))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                Picker(localized("Трудност", "Difficulty"), selection: $selectedDifficulty) {
                    ForEach(Difficulty.allCases) { difficulty in
                        Text(difficulty.title(for: selectedLanguage)).tag(difficulty)
                    }
                }
                .pickerStyle(.segmented)

                if categories.isEmpty {
                    ContentUnavailableView(
                        localized("Няма заредени въпроси", "No Questions Loaded"),
                        systemImage: "questionmark.folder",
                        description: Text(localized("Провери локалните JSON файлове и опитай отново.", "Check the local JSON files and try again."))
                    )
                    .padding(.vertical, 36)
                } else {
                    LazyVStack(spacing: 18) {
                        ForEach(categories) { category in
                            let questionCount = category.questionCount(for: selectedDifficulty)
                            Button {
                                select(category)
                            } label: {
                                categoryCard(category, isSelected: selectedCategoryID == category.id)
                            }
                            .buttonStyle(CategoryCardButtonStyle())
                            .disabled(questionCount == 0)
                            .opacity(questionCount == 0 ? 0.62 : 1)
                            .accessibilityIdentifier("categoryButton_\(category.id)")
                        }
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
        }
    }

    private func categoryCard(_ category: QuizCategory, isSelected: Bool) -> some View {
        let questionCount = category.questionCount(for: selectedDifficulty)
        let xpReward = questionCount * 10

        return VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 16) {
                categoryIcon(category)

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(category.title(for: selectedLanguage))
                                .font(.title3.weight(.bold))
                                .foregroundStyle(.primary)

                            Text(category.description(for: selectedLanguage))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer(minLength: 8)

                        difficultyBadge
                    }
                }
            }

            HStack(spacing: 10) {
                infoPill(
                    title: localized("Въпроси", "Questions"),
                    value: "\(questionCount)",
                    icon: "questionmark.circle.fill",
                    color: category.color
                )

                infoPill(
                    title: localized("XP награда", "XP Reward"),
                    value: "+\(xpReward) XP",
                    icon: "bolt.fill",
                    color: .orange
                )
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.regularMaterial)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(isSelected ? category.color.opacity(0.9) : category.color.opacity(0.18), lineWidth: isSelected ? 2 : 1)
        }
        .shadow(color: category.color.opacity(isSelected ? 0.28 : 0.16), radius: isSelected ? 22 : 16, x: 0, y: isSelected ? 12 : 8)
        .scaleEffect(!reduceMotion && isSelected ? 0.985 : 1)
        .animation(reduceMotion ? nil : .spring(response: 0.28, dampingFraction: 0.78), value: isSelected)
    }

    private func categoryIcon(_ category: QuizCategory) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [category.color.opacity(0.92), category.color.opacity(0.58)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 74, height: 74)
                .shadow(color: category.color.opacity(0.24), radius: 14, x: 0, y: 8)

            Image(systemName: category.icon)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.white)
        }
    }

    private var difficultyBadge: some View {
        Text(selectedDifficulty.title(for: selectedLanguage))
            .font(.caption.weight(.bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(difficultyColor.opacity(0.14))
            .foregroundStyle(difficultyColor)
            .clipShape(Capsule())
    }

    private func infoPill(title: String, value: String, icon: String, color: Color) -> some View {
        HStack(spacing: 9) {
            Image(systemName: icon)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(color)
                .frame(width: 28, height: 28)
                .background(color.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)

                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground).opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var difficultyColor: Color {
        switch selectedDifficulty {
        case .beginner:
            return .green
        case .intermediate:
            return .blue
        case .advanced:
            return .purple
        }
    }

    private func select(_ category: QuizCategory) {
        withAnimation(reduceMotion ? nil : .spring(response: 0.25, dampingFraction: 0.75)) {
            selectedCategoryID = category.id
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            onSelectCategory(category)
        }
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
