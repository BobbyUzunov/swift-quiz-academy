# Contributing

Thanks for considering a contribution to Swift Quiz Academy.

## Development Setup

1. Clone the repository.
2. Open `Swift Quiz Academy.xcodeproj` in Xcode.
3. Select the `Swift Quiz Academy` scheme.
4. Build and run on an iOS Simulator.

## Branch Naming

Use short, descriptive branch names:

```text
feature/daily-rewards
fix/xp-progress
docs/readme-update
```

## Pull Request Checklist

Before opening a pull request:

- Build the app successfully.
- Run the unit tests when possible.
- Keep changes focused on one feature or fix.
- Update documentation when behavior changes.
- Avoid committing generated build artifacts or local Xcode user data.

## Code Style

- Follow the existing SwiftUI and MVVM patterns.
- Keep business logic in models or view models.
- Keep views focused on presentation.
- Prefer small, readable helpers over duplicated code.
- Add comments only when they clarify non-obvious behavior.
