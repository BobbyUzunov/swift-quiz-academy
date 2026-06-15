//
//  QuizReviewItem.swift
//  Swift Quiz Academy
//

import Foundation

struct QuizReviewItem: Identifiable {
    let id = UUID()
    let question: String
    let selectedAnswer: String
    let correctAnswer: String
    let explanation: String
    let isCorrect: Bool
}
