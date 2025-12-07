# 📱 Flutter Clean Architecture App

This is a Flutter mobile application built using **Clean Architecture** principles.
The project is structured to be **scalable, testable, and easy to maintain**, with a clear separation between **UI, business logic, and data sources**.

---

## 🧱 Project Architecture

The project follows this layered structure:

```
lib/
├── app/           → Core app configuration and helpers
├── data/          → API, local storage, DTOs, and repositories implementation
├── domain/        → Business logic (models, use cases, repositories contracts)
├── presentation/  → UI layer (screens, widgets, view models)
```

Each layer has a single responsibility:

| Layer          | Responsibility               |
| -------------- | ---------------------------- |
| `app`          | App-level config & utilities |
| `data`         | Fetching and mapping data    |
| `domain`       | Business rules & use cases   |
| `presentation` | UI and state management      |

---

## 🗂 Folder Structure Explanation

### 1. `app/` – Core Application Setup

Contains global configuration and helpers:

| File                           | Description                               |
| ------------------------------ | ----------------------------------------- |
| `app_pref.dart`                | SharedPreferences wrapper (local storage) |
| `constants.dart`               | Global constants                          |
| `dependency_injection.dart`    | GetIt + Injectable setup                  |
| `extensions.dart`              | Dart extension methods                    |
| `flavor_config.dart`           | App flavors (Free / Premium / Common)     |
| `functions.dart`               | Reusable global helper functions          |
| `insecure_http_overrides.dart` | Allow self-signed SSL (dev only)          |
| `navigation_service.dart`      | Global navigation without context         |
| `network_aware_widget.dart`    | Detects network connection state          |

---

### 2. `data/` – Data Layer (External & Local Data)

Responsible for **fetching and converting raw data**.

#### `data_source/`

| File                      | Description              |
| ------------------------- | ------------------------ |
| `local_data_source.dart`  | Reads/writes cached data |
| `remote_data_source.dart` | Handles API calls        |

#### `mappers/`

Converts API models (DTOs) into domain models.

Examples:

* `authentication_mapper.dart`
* `library_mapper.dart`
* `user_data_mapper.dart`
* `verify_mapper.dart`

#### `network/`

Handles all network operations.

| Folder/File              | Description                  |
| ------------------------ | ---------------------------- |
| `requests/`              | API request bodies (DTOs)    |
| `app_api.dart`           | Retrofit API definitions     |
| `dio_factory.dart`       | Dio HTTP client config       |
| `exception_handler.dart` | Central API error handler    |
| `failure.dart`           | Custom failure models        |
| `network_info.dart`      | Network connectivity checker |

#### `repository/`

Concrete implementation of domain repositories.

---

### 3. `domain/` – Business Logic Layer

This layer contains the **core logic of the app**.

#### `models/`

Pure business models used by the app:

* `login_model.dart`
* `user_data_model.dart`
* `notifications_model.dart`
* `library_model.dart`, etc.

#### `repository/`

Abstract repository contracts (interfaces).

#### `usecase/`

Each **use case represents a single business action**.

Examples:

| Use Case                         | Responsibility            |
| -------------------------------- | ------------------------- |
| `login_usecase.dart`             | User login                |
| `register_usecase.dart`          | User registration         |
| `report_break_down_usecase.dart` | Report elevator breakdown |
| `upload_media_usecase.dart`      | Upload images/files       |
| `notification_usecase.dart`      | Handle notifications      |

---

### 4. `presentation/` – UI Layer

Contains **screens, UI widgets, and ViewModels**.

#### Screens (Examples)

| Feature       | Files                                                   |
| ------------- | ------------------------------------------------------- |
| Login         | `login_view.dart`, `login_viewmodel.dart`               |
| Register      | `register_view.dart`, `register_viewmodel.dart`         |
| Verify        | `verify_view.dart`, `verify_viewmodel.dart`             |
| Home          | `home_view.dart`, `home_viewmodel.dart`                 |
| Notifications | `notification_view.dart`, `notification_viewmodel.dart` |
| Library       | `library_view.dart`, `library_viewmodel.dart`           |
| Profile       | Profile-related screens & viewmodels                    |

#### `common/`

Contains reusable UI states:

* `state_renderer.dart` → Loading / Error / Success UI
* `freezed_data_classes.dart` → Freezed state models

#### `resources/`

App styling and constants:

| File                  | Purpose           |
| --------------------- | ----------------- |
| `color_manager.dart`  | App colors        |
| `font_manager.dart`   | Fonts             |
| `routes_manager.dart` | Navigation routes |
| `styles_manager.dart` | Text styles       |
| `theme_manager.dart`  | App themes        |

---

### 5. Firebase & Main Files

| File                    | Purpose                         |
| ----------------------- | ------------------------------- |
| `firebase_options.dart` | Firebase configuration          |
| `main_common.dart`      | Entry point for common flavor   |
| `main_free.dart`        | Entry point for Free version    |
| `main_premium.dart`     | Entry point for Premium version |

---

## ✨ Key Features

✅ Authentication (Login, Register, OTP, Reset Password)
✅ User Profile Management
✅ Notifications (Local & Push)
✅ Library / Catalogue Module
✅ File & Media Upload
✅ Technical Requests & Site Surveys
✅ Multi-Flavors (Free / Premium)
✅ Offline Handling
✅ Clean Architecture & Dependency Injection

---

## 🔧 Tech Stack

* Flutter (Dart)
* Clean Architecture
* MVVM
* GetIt + Injectable (DI)
* Dio + Retrofit
* Freezed
* Firebase
* SharedPreferences

---

## 🧭 How the App Works (Flow)

```
UI → ViewModel → UseCase → Repository (Domain)
→ Remote/Local Data Source → API/Cache
→ Mapper → Domain Model → Back to UI
```

---

## 🚀 Running the Project

```bash
flutter pub get
flutter run -t lib/main_common.dart
```

For flavors:

```bash
flutter run -t lib/main_free.dart
flutter run -t lib/main_premium.dart
```

---

## 🧠 Project Goal

This project is designed to demonstrate:

* Strong architecture principles
* Scalable codebase
* Clean separation of concerns
* Real-world production-ready structure
