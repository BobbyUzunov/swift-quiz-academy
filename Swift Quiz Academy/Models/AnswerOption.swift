//
//  AnswerOption.swift
//  Swift Quiz Academy
//

import Foundation

struct AnswerOption: Identifiable {
    let id = UUID()
    let text: String
    let isCorrect: Bool
}
