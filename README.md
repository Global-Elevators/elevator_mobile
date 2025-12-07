# 🚧 Elevator Maintenance Request App

## 🏗️ Architecture Overview

This project follows **Clean Architecture** with strict, production-ready separation of concerns:

```
Presentation (UI + ViewModels + State Management)
        ↓
Domain (Entities + Use Cases + Business Rules)
        ↓
Data (Repositories + Data Sources + DTOs + API Layer)
        ↓
Remote APIs / Local Storage / Firebase Services
```

### Architectural Patterns Used

* Clean Architecture
* MVVM (Model–View–ViewModel)
* Repository Pattern
* Dependency Injection (GetIt + Injectable)
* State Rendering using FlowState
* Functional error handling with Either<Failure, T>

---

## 🧩 Project Structure

```
lib/
├── app/
├── data/
├── domain/
├── presentation/
├── firebase_options.dart
├── main_common.dart
├── main_free.dart
├── main_premium.dart
```

Each layer is completely isolated to maintain scalability and testability.

---

## 📁 Layer Responsibilities (Detailed)

### 1. `app/` – Application Core Layer

This module manages the **foundation of the application**:

**Key responsibilities:**

* Flavor management (Free / Premium / Common)
* Global dependency injection bootstrap
* Secure preference handling
* Global constants & helper utilities
* Custom navigation without BuildContext
* Network connectivity awareness
* HTTP override for development/testing environments

**Important files:**

* `dependency_injection.dart` → Initializes all services via GetIt + Injectable
* `navigation_service.dart` → Global navigator using keys
* `app_pref.dart` → SharedPreferences abstraction
* `network_aware_widget.dart` → Online/Offline UI awareness

---

### 2. `data/` – Data Layer (Infrastructure Layer)

Handles **all external data interactions**.

#### ✅ Core Responsibilities

* REST API communication
* Local caching
* Request/Response serialization
* Exception → Failure mapping
* DTO → Domain model transformations

---

### 📡 Remote Networking System

Uses **Dio + Retrofit**.

#### Key Components:

| File                     | Purpose                                        |
| ------------------------ | ---------------------------------------------- |
| `dio_factory.dart`       | Configures Dio client, timeouts & interceptors |
| `app_api.dart`           | Retrofit endpoint definitions                  |
| `exception_handler.dart` | Centralized error handler                      |
| `network_info.dart`      | Runtime connectivity checker                   |
| `failure.dart`           | Failure object model                           |

---

### 📨 API Request Models

Located in:

```
data/network/requests/
```

Examples:

* `login_request.dart`
* `register_request.dart`
* `change_password_request.dart`
* `report_break_down_request.dart`
* `request_site_survey_request.dart`
* `technical_commercial_offers_request.dart`
* `update_user_request.dart`
* `verify_request.dart`

---

### 🔄 Mappers

Located in:

```
data/mappers/
```

Their job is:

```
API Response DTO → Domain Model
Domain Model → API Request DTO
```

Examples:

* `authentication_mapper.dart`
* `user_data_mapper.dart`
* `library_mapper.dart`
* `notification_mapper.dart`
* `upload_media_mapper.dart`

---

### 🗄️ Data Sources

| Component          | Description                         |
| ------------------ | ----------------------------------- |
| `RemoteDataSource` | Calls REST APIs                     |
| `LocalDataSource`  | Caches data using SharedPreferences |

---

### 🧾 Repository Implementations

Concrete implementations of domain repositories:

```
data/repository/repository.dart
```

This layer decides **where the data comes from**:

* API
* Cache
* Fallback strategies

---

## 🧠 Domain Layer (Business Logic)

This is the **heart of the system**.

### ✅ Models

Pure Dart entities under:

```
domain/models/
```

Examples:

* `login_model.dart`
* `user_data_model.dart`
* `library_model.dart`
* `notifications_model.dart`
* `upload_media_model.dart`

---

### 🔐 Notification System

Implemented under:

```
domain/notification/
```

Features:

* Local notifications
* Push notifications (Firebase)
* Notification lifecycle management
* Read/delete tracking

---

### 📌 Use Cases (Full Feature Coverage)

Each file in `domain/usecase/` represents a **real business feature**:

| Use Case                                   | Feature                      |
| ------------------------------------------ | ---------------------------- |
| `login_usecase.dart`                       | User authentication          |
| `logout_usecase.dart`                      | End session                  |
| `register_usecase.dart`                    | User registration            |
| `verify_usecase.dart`                      | OTP verification             |
| `resend_otp_usecase.dart`                  | Resend verification codes    |
| `forget_password_usecase.dart`             | Forgot password flow         |
| `reset_password_usecase.dart`              | Reset user password          |
| `change_password_usecase.dart`             | Change password from profile |
| `user_data_usecase.dart`                   | Fetch profile data           |
| `update_data_usecase.dart`                 | Update user information      |
| `library_usecase.dart`                     | Fetch documents & manuals    |
| `upload_media_usecase.dart`                | Upload images/files          |
| `report_break_down_usecase.dart`           | Report elevator breakdown    |
| `request_site_survey_usecase.dart`         | Request site inspections     |
| `technical_commercial_offers_usecase.dart` | Request technical offers     |
| `next_appointment_usecase.dart`            | Get upcoming appointments    |
| `reschedule_appointment_usecase.dart`      | Reschedule service visits    |
| `notification_usecase.dart`                | Fetch notifications          |
| `read_all_notifications_usecase.dart`      | Mark notifications as read   |
| `delete_notification_usecase.dart`         | Delete notifications         |
| `save_fcm_token_usecase.dart`              | Register device push token   |
| `sos_usecase.dart`                         | Emergency SOS requests       |

---

## 🖥️ Presentation Layer (UI + MVVM)

### ✅ ViewModel Architecture

Each screen has:

```
View  →  ViewModel  →  UseCase
```

ViewModels only talk to **domain use cases**, never to data sources directly.

---

### 📱 Feature Modules

| Feature        | Screens                                                         |
| -------------- | --------------------------------------------------------------- |
| Authentication | Login, Register, Verify, Forgot Password, Reset Password        |
| Home           | Dashboard, Notifications, Technical Requests, Breakdown Reports |
| Library        | Document listing & PDF viewer                                   |
| Profile        | Change password, Edit profile, Contract status                  |
| SOS            | Emergency request system                                        |

---

### 🔄 State Management

Handled via:

* `FlowState` for loading/content/error/empty states
* `Freezed` for immutable data classes
* `StateRenderer` to unify UI state behavior

---

## 🔐 Security & Infrastructure

* JWT token handling
* Encrypted preferences where supported
* Dio interceptors for token injection
* Safe failure wrapping using Either pattern
* SSL bypass only in debug mode

---

## ⚡ Offline Support

* Network availability detection
* Graceful fallback UI when offline
* Cached data via local data source

---

## 🌍 Localization

Powered by:

```
easy_localization
```

Supports:

* Arabic (`ar`)
* English (`en`)

Dynamic RTL/LTR switching supported.

---

## 🚀 Running the Project

Install packages:

```bash
flutter pub get
```

Run flavors:

```bash
flutter run -t lib/main_common.dart
flutter run -t lib/main_free.dart
flutter run -t lib/main_premium.dart
```

---

## 📌 Design Principles

* SOLID
* Dependency Inversion
* Modular architecture
* Scalability-first
* Testability-first
