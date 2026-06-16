# Changelog

All notable changes to Swift Quiz Academy are documented here.

## [1.3.1] - 2026-06-16

### Fixed

- Fixed Perfect Score and Perfect Quiz Master achievement logic for expanded 21-question quizzes.
- Perfect achievements now unlock only when `correctAnswers == totalQuestions` / score percentage is exactly 100%.
- Prevented 20/21 and 10/21 results from unlocking perfect achievements.

### Added

- Standalone JSON question database validation script for local and CI usage.
- Unit tests for perfect achievement edge cases.
- Unit tests for JSON validation failures, including duplicate IDs, missing translations, and invalid answer counts.

### Changed

- Updated GitHub Actions to validate JSON, build the project, and run unit tests.

## [1.3.0] - 2026-06-16

### Added

- Expanded the local JSON question database to 504 questions.
- Added new learning categories:
  - Git & GitHub
  - Architecture & MVVM
  - Xcode & Debugging
- Renamed and expanded content for iOS Development and AI for Developers.
- Added 21 Beginner, 21 Intermediate, and 21 Advanced questions per category.
- Added practical scenario-based questions across Swift, SwiftUI, iOS, programming logic, AI-assisted development, Git workflows, MVVM architecture, and debugging.
- Added useful explanations for every question in Bulgarian and English.
- Added strict automated database validation for duplicate IDs, exact answer counts, correct answers, category IDs, difficulty values, and explanations.
- Added category mastery tracking with total questions, completed questions, and mastery percentage.

### Changed

- Updated category metadata to load 8 JSON-backed categories.
- Updated Settings statistics to include Category Mastery.
- Updated tests for the 504-question database.

## [1.2.0] - 2026-06-15

### Added

- Local JSON question database with one file per quiz category.
- `QuestionLoader` service for Bundle loading, decoding, validation, and grouping questions by category and difficulty.
- Safe empty state for missing or failed question loading.
- `PrivacyInfo.xcprivacy` with no tracking, no collected data, and UserDefaults required-reason API declaration.
- Persistence schema versioning for safe future UserDefaults migrations.
- Unit tests for JSON loading, decoding, grouping, and filtering by difficulty.
- Unit tests for persistence schema initialization and Practice Mistakes identifier migration.

### Changed

- Refactored main quiz categories to load questions from JSON instead of hardcoded Swift arrays.
- Updated `QuizQuestion` to support JSON fields for IDs, category IDs, difficulty, localized questions, localized answers, correct answer text, and localized explanations.
- Made `Difficulty` codable for JSON decoding.
- Set the project deployment target to iOS 17.0.
- Set Xcode project version settings to marketing version 1.2 and build 1.
- Changed Practice Mistakes persistence to use stable `question.id` values, with migration for legacy `questionEN` records.
- Improved `QuestionLoader` diagnostics with debug-only logging while keeping graceful empty fallbacks.
- Added basic accessibility labels/values for XP progress, answer buttons, and the Daily Reward popup.
- Reduced confetti and repeating animations when Reduce Motion is enabled.
- Updated README with Version 1.2 details.

## [1.1.0] - 2026-06-15

### Added

- Daily Reward system with +25 XP once per day.
- 7-day login streak bonus with +100 XP.
- Login streak and best login streak tracking.
- Global Light, Dark, and System theme preference.
- Animated XP progress bar on the Home screen.
- Reward claim popup with animation.
- Confetti feedback for newly unlocked achievements.
- New achievements:
  - 7 Day Streak
  - 500 XP
  - 1000 XP
  - 10 Quizzes Played
  - 50 Correct Answers
  - Perfect Quiz Master
- Unit tests for daily rewards, theme persistence, achievements, localization, and level progression.

### Changed

- Improved Home screen spacing, cards, shadows, and Start Quiz animation.
- Expanded persistence through `QuizProgressStore`.
- Updated README with Version 1.1 details.

## [1.0.0] - 2026-06-11

### Added

- Initial SwiftUI quiz app.
- Quiz categories and difficulty levels.
- XP, levels, achievements, statistics, and daily challenge.
- Practice Mistakes and answer review.
- Bulgarian and English localization.
- UserDefaults progress persistence.
