# Swift Quiz Academy

![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS-blue)
![Architecture](https://img.shields.io/badge/MVVM-Architecture-green)
![Version](https://img.shields.io/badge/Version-1.1-success)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Persistence](https://img.shields.io/badge/Persistence-UserDefaults-blueviolet)

Swift Quiz Academy is a modern SwiftUI learning app for practicing Swift, SwiftUI, iOS concepts, logic, and AI fundamentals through interactive quizzes, XP progression, achievements, and daily learning habits.

---

## Table of Contents

- [Screenshots](#screenshots)
- [Features](#features)
- [Version 1.1 Highlights](#version-11-highlights)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Tests](#tests)
- [Roadmap](#roadmap)
- [Contributing](#contributing)

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

## Requirements

- macOS with Xcode installed
- Xcode 16 or newer recommended
- iOS Simulator or iOS device
- Swift 6 compatible toolchain

---

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/BobbyUzunov/swift-quiz-academy.git
```

2. Open the project in Xcode:

```bash
open "Swift Quiz Academy.xcodeproj"
```

3. Select the `Swift Quiz Academy` scheme.

4. Build and run on an iOS Simulator.

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

## Project Structure

```text
Swift Quiz Academy/
├── Models/
│   ├── Achievement.swift
│   ├── AppLanguage.swift
│   ├── AppTheme.swift
│   ├── DailyReward.swift
│   ├── Difficulty.swift
│   ├── QuizCategory.swift
│   └── QuizQuestion.swift
├── ViewModels/
│   ├── QuizProgressStore.swift
│   └── QuizViewModel.swift
├── Views/
│   ├── HomeView.swift
│   ├── QuizView.swift
│   ├── SettingsView.swift
│   └── CelebrationViews.swift
├── Assets.xcassets/
└── Swift_Quiz_AcademyApp.swift
```

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

Run the app build locally:

```bash
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
xcodebuild build \
  -project "Swift Quiz Academy.xcodeproj" \
  -scheme "Swift Quiz Academy" \
  -destination "generic/platform=iOS" \
  CODE_SIGNING_ALLOWED=NO
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

## Contributing

Contributions, ideas, and improvements are welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for setup, branch, and pull request guidelines.

---

## License

This project is available under the [MIT License](LICENSE).

---

## Author

Boncho Uzunov

GitHub: https://github.com/BobbyUzunov

---

## Support

If you found this project useful, consider giving it a star.
