//
//  AppLanguage.swift
//  Swift Quiz Academy
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case bulgarian
    case english

    var id: String { rawValue }

    var title: String {
        switch self {
        case .bulgarian:
            return "🇧🇬 Български"
        case .english:
            return "🇬🇧 English"
        }
    }

    func localized(_ bg: String, _ en: String) -> String {
        switch self {
        case .bulgarian:
            return bg
        case .english:
            return en
        }
    }
}
