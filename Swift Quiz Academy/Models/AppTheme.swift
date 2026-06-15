//
//  AppTheme.swift
//  Swift Quiz Academy
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    func title(for language: AppLanguage) -> String {
        switch self {
        case .system:
            return language.localized("Система", "System")
        case .light:
            return language.localized("Светла", "Light")
        case .dark:
            return language.localized("Тъмна", "Dark")
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
