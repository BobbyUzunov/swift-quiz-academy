# Changelog

All notable changes to Swift Quiz Academy are documented here.

## [1.5.0] - 2026-06-30

### Fixed

- Rebuilt intermediate and advanced questions for Git & GitHub, iOS Development, Architecture & MVVM, AI for Developers, Programming Logic, and Xcode & Debugging so each difficulty level is unique.
- Removed cross-difficulty duplicate question text (same stem on beginner, intermediate, and advanced).
- Replaced generic explanation templates and lazy Bulgarian prompts (`Developer трябва…`) with specific scenario-based copy.
- Rewrote SwiftUI English prompts to match the improved Bulgarian scenarios.

### Added

- Question bank modules in `Scripts/question_banks/` for maintainable content authoring.
- `Scripts/rebuild_question_database.mjs` to regenerate JSON from banks.
- CI guard that fails if committed `QuestionData` JSON drifts from question banks.
- Validation rule that rejects duplicate question text across difficulty levels in the same category.

### Changed

- Question database now contains **504 unique English question stems** (up from ~255 unique with heavy duplication).
- Marketing version bumped to **1.5.0**.

## [1.4.2] - 2026-06-30

### Fixed

- Daily Challenge now rotates by calendar day instead of always using the same beginner-first question set.
- Daily Challenge now marks completion only after a successful result, so Game Over no longer consumes the daily attempt.
- Aligned the on-device display name with the project name: Swift Quiz Academy.

### Changed

- Removed legacy hardcoded translation tables and the unused convenience initializer from `QuizQuestion`.
- Added `DailyChallengeBuilder` for deterministic daily mixed-quiz composition.
- Updated Daily Challenge copy to describe the mixed category/difficulty experience.
- Updated README architecture, project structure, and version documentation.
- Removed the placeholder launch screenshot UI test target file.

### Added

- Unit tests for daily challenge rotation, mixed difficulties, category coverage, and retry-after-game-over behavior.

## [1.4.1] - 2026-06-19

### Fixed

- Fixed celebration/confetti cleanup so no leftover particles or colored artifacts remain visible after the animation ends.
- Improved animation cleanup by removing the confetti overlay when inactive.
- Improved Dynamic Type behavior in Home, Library, Quiz, Result, and shared profile/stat layouts to reduce truncation and compressed text.
- Aligned Xcode marketing version with release documentation (`1.4.1`).
- Stabilized UI smoke tests with accessibility identifiers, English launch locale, and longer waits for full-quiz completion.

### Changed

- Daily Challenge now reuses the JSON-backed question database instead of hardcoded challenge questions.
- Decorative animations now respect the system Reduce Motion setting.
- GitHub Actions now selects an available iOS Simulator dynamically instead of depending on a hardcoded iPhone simulator name.
- GitHub Actions now runs UI smoke tests separately from unit tests with parallel testing disabled.
- Updated the README roadmap to reflect completed 1.3/1.4 work and upcoming 1.5/2.0 goals.

### Added

- Added UI smoke tests for app launch, starting a quiz, completing a quiz, opening Settings, and opening Library.
- Added accessibility identifiers for result actions and main tab destinations.

## [1.4.0] - 2026-06-16

### Added

- Added a new Library destination to browse questions outside quiz mode.
- Added Question Library totals and per-category question counts.
- Added live Library search across question and explanation text in Bulgarian and English.
- Added category and difficulty filters that work together.
- Added favorite questions persisted in UserDefaults by stable `question.id`.
- Added Favorite Questions browsing mode.
- Added question detail study screen with answers, correct answer, explanation, category, and difficulty.
- Added friendly empty states for empty database, no favorites, and no search results.
- Added Library statistics for total favorites and searches performed.
- Added unit tests for favorites persistence, search, filters, and empty states.

### Changed

- Updated main navigation to include Home, Library, and Settings.

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
