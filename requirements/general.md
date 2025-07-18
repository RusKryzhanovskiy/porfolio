# 📊 Portfolio Tracker App - Requirements

## 🧭 Overview
This is a cross-platform **Portfolio Tracker App** built with **Flutter**.  
Users can track and manage their investments across various asset classes in real-time with rich analytics and cloud syncing.

---

## 🧱 Tech Stack

- **Flutter**
- **State Management**: BLoC (Cubit)
- **Networking**: Dio
- **Local Storage**: Hive
- **Navigation**: GoRouter
- **Crash Reporting**: Firebase Crashlytics
- **Cloud Sync** (Planned): Firebase Firestore
- **Architecture**: Clean Architecture
- **Linting**: Custom linter rules enforced
- **Internationalization**: `l10n`, `i18n` ready

---

## 🔑 Core Features

### ✅ Portfolio Management
- Create and manage multiple porfolios
- Add or remove assets from each porfolio
- Asset types supported:
  - Cryptocurrency
  - Stocks
  - Metals
  - Coins
  - Cash

### 📈 Asset Analytics
- Fetch real-time prices for supported asset types
- View charts and analytics per porfolio:
  - Performance over time
  - Best/Worst performers
  - Total porfolio balance

### ☁️ Data Storage & Sync
- Offline-first: all data stored locally using Hive
- Optional cloud sync with Firebase Firestore
- Data syncs from Hive to Firebase upon user request or when connected

---

## 🧩 Architecture & Code Quality

- Modular & scalable **Clean Architecture** to support long-term growth
- Each feature is isolated with:
  - `data/`, `domain/`, and `presentation/` layers
- Linting and formatting strictly enforced
- Fully extendable structure for adding new asset types or features with minimal refactoring

---

## 🌍 Internationalization

- App supports multiple locales using Flutter's `l10n` and `i18n`
- All user-facing strings must be localized

---

## 🚧 Planned Improvements

- Firebase Firestore integration for cross-device syncing
- In-app notifications or alerts
- Asset import from external APIs or files
