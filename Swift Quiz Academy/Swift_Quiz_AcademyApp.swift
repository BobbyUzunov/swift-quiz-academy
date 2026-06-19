//
//  Swift_Quiz_AcademyApp.swift
//  Swift Quiz Academy
//
//  Created by Boncho Uzunov on 11.06.26.
//

import SwiftUI

@main
struct Swift_Quiz_AcademyApp: App {
    init() {
        if CommandLine.arguments.contains("-resetUserDefaultsForUITests"),
           let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
