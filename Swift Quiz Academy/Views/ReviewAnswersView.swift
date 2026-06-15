//
//  ReviewAnswersView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct ReviewAnswersView: View {
    let items: [QuizReviewItem]
    let selectedLanguage: AppLanguage
    let onBackToResults: () -> Void
    let onHome: () -> Void

    private var correctCount: Int {
        items.filter(\.isCorrect).count
    }

    private var wrongCount: Int {
        items.count - correctCount
    }

    private var accuracyPercentage: Int {
        guard !items.isEmpty else { return 0 }
        return Int((Double(correctCount) / Double(items.count) * 100).rounded())
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                headerView
                summaryCard

                if items.isEmpty {
                    emptyStateCard
                } else {
                    LazyVStack(spacing: 14) {
                        ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                            reviewCard(item, index: index)
                        }
                    }
                }

                actionButtons
            }
            .padding(20)
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
        }
    }

    private var headerView: some View {
        VStack(spacing: 8) {
            Text(localized("Преглед на отговорите", "Review Answers"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(localized("Виж какво си избрал и преговори обясненията.", "Review what you picked and study the explanations."))
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var summaryCard: some View {
        HStack(spacing: 12) {
            summaryItem(title: localized("Правилни", "Correct"), value: "\(correctCount)", color: .green)
            summaryItem(title: localized("Грешни", "Wrong"), value: "\(wrongCount)", color: .red)
            summaryItem(title: localized("Успеваемост", "Accuracy"), value: "\(accuracyPercentage)%", color: .blue)
        }
        .padding(16)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 14, x: 0, y: 8)
    }

    private var emptyStateCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(.blue)

            Text(localized("Няма отговори за преглед.", "No answers to review."))
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(localized("Завърши quiz, за да видиш подробен преглед на отговорите си.", "Complete a quiz to see a detailed review of your answers."))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 14, x: 0, y: 8)
    }

    private func summaryItem(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.title2.weight(.bold))
                .foregroundStyle(color)

            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity)
    }

    private func reviewCard(_ item: QuizReviewItem, index: Int) -> some View {
        let statusColor = item.isCorrect ? Color.green : Color.red

        return VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Text(localized("Въпрос \(index + 1)", "Question \(index + 1)"))
                    .font(.headline.weight(.bold))

                Spacer()

                Label(item.isCorrect ? localized("Правилен", "Correct") : localized("Грешен", "Incorrect"), systemImage: item.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(statusColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(statusColor.opacity(0.12))
                    .clipShape(Capsule())
            }

            reviewSection(title: localized("Въпрос", "Question"), value: item.question)
            reviewSection(title: localized("Твоят отговор", "Your Answer"), value: item.selectedAnswer)
            reviewSection(title: localized("Правилен отговор", "Correct Answer"), value: item.correctAnswer)
            reviewSection(title: localized("Обяснение", "Explanation"), value: item.explanation)
        }
        .padding(18)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(statusColor.opacity(0.18), lineWidth: 1)
        }
        .shadow(color: statusColor.opacity(0.10), radius: 14, x: 0, y: 8)
    }

    private func reviewSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body.weight(.semibold))
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button(action: onBackToResults) {
                Text(localized("Назад към резултата", "Back to Results"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)

            Button(action: onHome) {
                Text(localized("Към началото", "Back to Home"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
