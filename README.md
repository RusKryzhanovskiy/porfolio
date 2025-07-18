# Portfolio Tracker

A cross-platform mobile application built with Flutter for tracking investment portfolios, monitoring crypto markets, and analyzing financial assets.

## Features

- 📊 Real-time crypto market data
- 💼 Portfolio management
- 📈 Investment analytics
- 🌐 Multi-currency support (USD, EUR, UAH)
- 🌍 Localization (English, Ukrainian)
- 📱 Offline-first architecture

## Architecture

The project follows a feature-first architecture with clean separation of concerns:

```
lib/
├── features/          # Feature modules
│   ├── markets/       # Crypto markets feature
│   ├── portfolio/     # Portfolio management
│   ├── profile/       # User settings
│   └── analytics/     # Analytics and charts
├── core/              # Core infrastructure
│   ├── network/       # Network layer
│   ├── cache/         # Caching system
│   └── repository/    # Base repository
├── services/          # Global services
└── l10n/             # Localization
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK (latest stable)
- Android Studio / Xcode
- A CoinMarketCap API key

### Environment Setup

1. Clone the repository:
```bash
git clone https://github.com/RusKryzhanovskiy/porfolio.git
cd porfolio
```

2. Create a `.env` file in the project root:
```
COINMARKETCAP_API_KEY=your_api_key_here
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Tech Stack

- **State Management**: BLoC/Cubit + Provider
- **Networking**: Dio with custom error handling
- **Local Storage**: Hive for offline data
- **Dependency Injection**: Provider
- **Localization**: Flutter gen-l10n
- **Navigation**: GoRouter

## Development Workflow

### Adding a New Feature

1. Create feature directory structure
2. Implement domain models and interfaces
3. Create data sources and repositories
4. Add presentation layer with Cubit/BLoC
5. Connect to global services if needed

### Localization

1. Add new strings to:
   - `lib/l10n/app_en.arb` (English)
   - `lib/l10n/app_uk.arb` (Ukrainian)
2. Run: `flutter gen-l10n`

### Testing

Run tests with:
```bash
flutter test
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Submit a pull request

## Architecture Decisions

- **Offline-First**: All network responses are cached for offline access
- **Feature-First**: Each feature is self-contained with its own layers
- **Global State**: Managed by Provider for app-wide settings
- **Error Handling**: Using sealed classes for type-safe error handling

## License

This project is licensed under the MIT License - see the LICENSE file for details.
