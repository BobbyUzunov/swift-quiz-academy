# Swift Quiz Academy

![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS-blue)
![Architecture](https://img.shields.io/badge/MVVM-Architecture-green)
![Version](https://img.shields.io/badge/Version-1.1-success)

Swift Quiz Academy is a modern SwiftUI learning app for practicing Swift, SwiftUI, iOS concepts, logic, and AI fundamentals through interactive quizzes, XP progression, achievements, and daily learning habits.

---

## Screenshots

<p align="center">
  <img src="screenshots/Home.png" width="220">
  <img src="screenshots/Quiz.png" width="220">
  <img src="screenshots/Setting.png" width="220">
  <img src="screenshots/App.png" width="220">
</p>

---

## Features

- Interactive quiz categories for Swift, SwiftUI, iOS, Logic, and AI
- Beginner, Intermediate, and Advanced difficulty levels
- XP system with animated level progress
- 10-level progression system with Swift-themed titles
- Daily Reward system: +25 XP once per day
- 7-day login streak bonus: +100 XP
- Daily Challenge mode with bonus XP
- Achievement system with automatic unlocks
- Practice Mistakes mode for reviewing missed questions
- Answer review screen after quizzes
- Statistics tracking for XP, games played, answers, accuracy, streaks, and high score
- Bulgarian and English localization
- Light, Dark, and System theme support
- UserDefaults persistence for progress, language, theme, streaks, rewards, mistakes, and achievements
- Modern SwiftUI interface with animated cards, reward popup, progress bar, and confetti feedback

---

## Version 1.1 Highlights

- Added Daily Rewards with once-per-day claiming
- Added login streak and best login streak tracking
- Added 7-day reward bonus
- Improved Home XP progress bar
- Added global Dark Mode preference
- Added new achievements:
  - 7 Day Streak
  - 500 XP
  - 1000 XP
  - 10 Quizzes Played
  - 50 Correct Answers
  - Perfect Quiz Master
- Added reward claim animation and achievement confetti
- Added focused unit tests for rewards, theme persistence, level progression, localization, and achievements

---

## Architecture

The app follows an MVVM structure with small supporting models and persistence helpers.

```text
Swift Quiz Academy/
├── Models/
├── ViewModels/
├── Views/
└── Assets.xcassets/
```

Key pieces:

- `QuizViewModel` manages quiz state, XP, levels, rewards, achievements, statistics, and navigation.
- `QuizProgressStore` centralizes UserDefaults persistence.
- `DailyRewardManager` handles daily reward and login streak calculations.
- `AppTheme` manages Light, Dark, and System theme selection.

---

## Tech Stack

- Swift
- SwiftUI
- Observation
- MVVM
- UserDefaults
- Swift Testing
- Xcode

---

## Tests

The project includes unit tests for:

- Quiz answer flow
- XP and level progression
- Daily Challenge reward behavior
- Daily Reward claiming and 7-day bonus
- Theme preference persistence
- Achievement unlocking
- Progress reset and reload
- Bulgarian question localization

Latest local verification:

```text
xcodebuild test   - passed
xcodebuild build  - passed
```

---

## Roadmap

### Version 1.2

- Cloud synchronization
- User profiles
- Online leaderboards
- More quiz categories
- Expanded question database

### Version 2.0

- Multiplayer challenges
- Community features
- Advanced learning paths
- App Store polish

---

## Author

Boncho Uzunov

GitHub: https://github.com/BobbyUzunov

---

## Support

If you found this project useful, consider giving it a star.
