# Changelog

All notable changes to Swift Quiz Academy are documented here.

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
