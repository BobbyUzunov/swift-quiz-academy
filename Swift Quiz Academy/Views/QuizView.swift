//
//  QuizView.swift
//  Swift Quiz Academy
//

import SwiftUI

struct QuizView: View {
    let category: QuizCategory
    let selectedDifficulty: Difficulty
    let selectedLanguage: AppLanguage
    let currentQuestion: QuizQuestion
    let answerOptions: [AnswerOption]
    let currentQuestionIndex: Int
    let totalQuestions: Int
    let progressValue: Double
    let xp: Int
    let streak: Int
    let lives: Int
    let selectedAnswerIndex: Int?
    let feedbackMessage: String?
    let feedbackIsCorrect: Bool?
    let isLastQuestion: Bool
    let onBack: () -> Void
    let onSelectAnswer: (Int) -> Void
    let onNextQuestion: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack {
                    Button(action: onBack) {
                        Label(localized("Назад", "Back"), systemImage: "chevron.left")
                            .font(.headline)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.blue)

                    Spacer()
                }

                quizHeaderView

                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 10) {
                        Label(category.title(for: selectedLanguage), systemImage: category.icon)
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(category.color)

                        Spacer()

                        Text(selectedDifficulty.title(for: selectedLanguage))
                            .font(.caption.weight(.bold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.12))
                            .clipShape(Capsule())
                    }

                    Text(currentQuestion.questionText(for: selectedLanguage))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 12) {
                        ForEach(answerOptions.indices, id: \.self) { index in
                            answerButton(for: index)
                        }
                    }

                    if let feedbackMessage, let feedbackIsCorrect {
                        explanationCard(feedbackMessage: feedbackMessage, feedbackIsCorrect: feedbackIsCorrect)
                    }
                }
                .padding(20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 22, x: 0, y: 12)

                Button(action: onNextQuestion) {
                    Text(isLastQuestion ? localized("Виж резултата", "See Result") : localized("Следващ въпрос", "Next Question"))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .disabled(selectedAnswerIndex == nil || lives == 0)
                .opacity(selectedAnswerIndex == nil || lives == 0 ? 0.55 : 1)
            }
            .padding(20)
            .frame(maxWidth: 680)
            .frame(maxWidth: .infinity)
        }
    }

    private func explanationCard(feedbackMessage: String, feedbackIsCorrect: Bool) -> some View {
        let correctAnswer = answerOptions.first(where: { $0.isCorrect })?.text ?? currentQuestion.correctAnswerText(for: selectedLanguage)
        let color = feedbackIsCorrect ? Color.green : Color.red

        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: feedbackIsCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                Text(feedbackMessage)
                    .fontWeight(.bold)

                if streak >= 3 {
                    Text(localized("Гореща поредица!", "Hot streak!"))
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                }
            }
            .font(.headline)
            .foregroundStyle(color)

            VStack(alignment: .leading, spacing: 6) {
                Text(localized("Правилен отговор", "Correct Answer"))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                Text(correctAnswer)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                Text(currentQuestion.explanationText(for: selectedLanguage))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(color.opacity(0.22), lineWidth: 1)
        }
    }

    private var quizHeaderView: some View {
        VStack(spacing: 14) {
            Text(localized("Swift Quiz Academy", "Swift Quiz Academy"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            HStack(spacing: 10) {
                metricPill(text: "\(xp) XP", icon: "bolt.fill", color: .orange)
                metricPill(text: localized("Поредица \(streak)", "Streak \(streak)"), icon: "flame.fill", color: .red)
                Spacer()
                heartsView
            }

            VStack(spacing: 8) {
                HStack {
                    Text(localized("Въпрос \(currentQuestionIndex + 1) / \(totalQuestions)", "Question \(currentQuestionIndex + 1) / \(totalQuestions)"))
                    Spacer()
                    Text("\(Int((progressValue * 100).rounded()))%")
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

                GeometryReader { proxy in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.primary.opacity(0.1))

                        Capsule()
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                            .frame(width: proxy.size.width * progressValue)
                    }
                }
                .frame(height: 12)
            }
        }
    }

    private var heartsView: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { index in
                Image(systemName: index < lives ? "heart.fill" : "heart")
                    .foregroundStyle(index < lives ? .red : .secondary)
                    .font(.title3)
                    .scaleEffect(index < lives ? 1.05 : 1)
            }
        }
        .accessibilityLabel(localized("\(lives) живота", "\(lives) lives"))
    }

    private func metricPill(text: String, icon: String, color: Color) -> some View {
        Label(text, systemImage: icon)
            .font(.subheadline.weight(.bold))
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(color.opacity(0.13))
            .clipShape(Capsule())
    }

    private func answerButton(for index: Int) -> some View {
        let answerOption = answerOptions[index]
        let isSelected = selectedAnswerIndex == index
        let isCorrect = answerOption.isCorrect
        let shouldHighlight = selectedAnswerIndex != nil && (isSelected || isCorrect)
        let backgroundColor = answerBackgroundColor(isSelected: isSelected, isCorrect: isCorrect)
        let foregroundColor = shouldHighlight ? Color.white : Color.primary

        return Button {
            onSelectAnswer(index)
        } label: {
            HStack(spacing: 12) {
                Text(String(UnicodeScalar(65 + index)!))
                    .font(.headline)
                    .frame(width: 34, height: 34)
                    .background(Color.white.opacity(shouldHighlight ? 0.24 : 0.72))
                    .clipShape(Circle())

                Text(answerOption.text)
                    .font(.body.weight(.semibold))
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 8)

                if selectedAnswerIndex != nil && (isSelected || isCorrect) {
                    Image(systemName: isCorrect ? "checkmark" : "xmark")
                        .font(.headline.weight(.bold))
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.22))
                        .clipShape(Circle())
                }
            }
            .foregroundStyle(foregroundColor)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.primary.opacity(selectedAnswerIndex == nil ? 0.08 : 0), lineWidth: 1)
            }
            .shadow(color: .black.opacity(shouldHighlight ? 0.16 : 0.07), radius: shouldHighlight ? 14 : 8, x: 0, y: shouldHighlight ? 8 : 4)
            .scaleEffect(isSelected ? 1.02 : 1)
        }
        .buttonStyle(.plain)
        .disabled(selectedAnswerIndex != nil)
    }

    private func answerBackgroundColor(isSelected: Bool, isCorrect: Bool) -> Color {
        guard selectedAnswerIndex != nil else {
            return Color(.secondarySystemBackground)
        }

        if isCorrect {
            return .green
        }

        if isSelected {
            return .red
        }

        return Color(.tertiarySystemBackground)
    }

    private func localized(_ bg: String, _ en: String) -> String {
        selectedLanguage.localized(bg, en)
    }
}
